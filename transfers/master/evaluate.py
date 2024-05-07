from __future__ import print_function

import base64
import sys
sys.path.insert(0, 'src')
import transform, numpy as np,pdb, os
import tensorflow as tf
from utils import save_img, get_img, exists, list_files
from argparse import ArgumentParser
from collections import defaultdict

BATCH_SIZE = 4
DEVICE = '/gpu:0'
checkpoint_dir= '../checkpoints/scream.ckpt'
in_dir= '../input_img/shanghai.jpeg'
out_dir= '../output_img/shanghai_output_scream2.jpg'

allow_different_dimensions = False

def ffwd(data_in, paths_out, checkpoint_dir, device_t='/gpu:0', batch_size=4, X=None):
    """
        参数:
            data_in: 可以是图像文件路径的列表，或者是已经加载的图像数据数组。
            paths_out: 输出结果保存路径的列表。
            checkpoint_dir: 检查点（模型权重）的目录路径。
            device_t: 用于计算的设备（如 '/gpu:0'）。
            batch_size: 批处理大小。
            X: 如果 data_in 是文件路径列表，则此参数未使用；如果 data_in 是图像数据，则这是图像数据。
        """
    assert len(paths_out) > 0, "paths_out 列表不能为空"

    # 判断 data_in 是否为文件路径列表
    is_paths = isinstance(data_in[0], str)

    if is_paths:
        # 确保 data_in 和 paths_out 的长度相同
        assert len(data_in) == len(paths_out), "data_in 和 paths_out 的长度必须相同"
        # 加载第一个图像以获取形状
        img_shape = get_img(data_in[0]).shape
    else:
        # 确保 data_in 的第一个维度与 paths_out 的长度相同
        assert data_in.shape[0] == len(paths_out), "data_in 的第一个维度必须与 paths_out 的长度相同"
        # 使用提供的 X（或 data_in）获取图像形状
        img_shape = X[0].shape if X is not None else data_in[0].shape

        # 创建 TensorFlow 图和会话
    with tf.Graph().as_default(), tf.device(device_t), tf.Session(
            config=tf.ConfigProto(allow_soft_placement=True, gpu_options=tf.GPUOptions(allow_growth=True))) as sess:
        # 定义输入占位符
        batch_shape = (batch_size,) + img_shape
        img_placeholder = tf.placeholder(tf.float32, shape=batch_shape, name='img_placeholder')

        # 使用预定义的模型计算预测
        preds = transform.net(img_placeholder)  # 假设 transform.net 已经定义

        # 创建 Saver 对象以加载模型权重
        saver = tf.train.Saver()

        # 加载检查点（模型权重）
        if os.path.isdir(checkpoint_dir):
            ckpt = tf.train.get_checkpoint_state(checkpoint_dir)
            if ckpt and ckpt.model_checkpoint_path:
                saver.restore(sess, ckpt.model_checkpoint_path)
            else:
                raise Exception("在指定目录中没有找到检查点...")
        else:
            # 注意：这里假设 checkpoint_dir 直接指向检查点文件，但在实际中不推荐这样做
            saver.restore(sess, checkpoint_dir)

            # 计算迭代次数
        num_iters = (len(paths_out) + batch_size - 1) // batch_size

        # 进行批处理迭代
        for i in range(num_iters):
            # 计算当前批次的起始索引
            pos = i * batch_size

            # 获取当前批次的输出路径
            curr_batch_out = paths_out[pos:pos + batch_size]

            # 根据输入类型加载图像数据
            if is_paths:
                # 从文件路径加载图像数据
                curr_batch_in = data_in[pos:pos + batch_size]
                X = np.zeros(batch_shape, dtype=np.float32)
                for j, path_in in enumerate(curr_batch_in):
                    img = get_img(path_in)  # 加载图像
                    assert img.shape == img_shape, '图像尺寸不一致，请调整尺寸或允许不同尺寸'
                    X[j] = img  # 将图像数据放入批处理数组
            else:
                # 如果输入已经是图像数据，则直接使用
                X = data_in[pos:pos + batch_size]

                # 在TensorFlow会话中运行模型以获取预测结果
            _preds = sess.run(preds, feed_dict={img_placeholder: X})

            # 保存预测结果到对应的文件路径
            for j, path_out in enumerate(curr_batch_out):
                save_img(path_out, _preds[j])  # 保存预测图像

        # 处理剩余的图像（如果有）
        # 如果数据不是批处理大小的整数倍，会有剩余数据
        remaining_in = data_in[num_iters * batch_size:]
        remaining_out = paths_out[num_iters * batch_size:]
        if len(remaining_in) > 0:
            # 使用批处理大小为1来处理剩余的图像
            ffwd(remaining_in, remaining_out, checkpoint_dir, device_t=device_t, batch_size=1)


def ffwd_to_img(in_path, out_path, checkpoint_dir, device='/cpu:0'):
    """
    对单个输入图像进行前向传递处理，并将结果保存到指定的输出路径。

    :param in_path: 输入图像的路径（字符串）。
    :param out_path: 输出图像的保存路径（字符串）。
    :param checkpoint_dir: 模型检查点的目录（字符串），用于加载模型参数。
    :param device: 运算设备，如'/cpu:0'代表第一个CPU，'/gpu:0'代表第一个GPU（可选）。
    """
    # 将输入和输出路径封装为列表，因为后续可能处理多个图像（尽管这里只处理一个）
    paths_in, paths_out = [in_path], [out_path]

    # 调用ffwd函数进行前向传递处理
    # ffwd函数已经定义，并接受路径列表、检查点目录、批量大小和运算设备作为参数
    # batch_size设置为1，因为我们只处理一个图像
    ffwd(paths_in, paths_out, checkpoint_dir, batch_size=1, device_t=device)

def ffwd_different_dimensions(in_path, out_path, checkpoint_dir,
                              device_t='cpu', batch_size=4):
    """
    对具有不同尺寸的图像进行前向传递处理。

    :param in_path: 输入图像的路径列表
    :param out_path: 输出图像的路径列表
    :param checkpoint_dir: 模型检查点的目录
    :param device_t: 设备类型，例如'cpu'或'cuda'
    :param batch_size: 批量处理图像的数量
    """
    # 使用defaultdict来存储相同尺寸的输入和输出图像路径
    in_path_of_shape = defaultdict(list)
    out_path_of_shape = defaultdict(list)

    # 遍历输入和输出路径列表
    for i in range(len(in_path)):
        in_image = in_path[i]
        out_image = out_path[i]

        # 获取图像的尺寸，并构造一个形如"宽度x高度x通道数"的字符串
        shape = "%dx%dx%d" % get_img(in_image)  # get_img是一个获取图像尺寸的函数

        # 将相同尺寸的输入和输出图像路径添加到对应的列表中
        in_path_of_shape[shape].append(in_image)
        out_path_of_shape[shape].append(out_image)

        # 对每个尺寸的图像进行前向传递处理
    for shape in in_path_of_shape:
        print('正在处理尺寸为 %s 的图像' % shape)
        # 调用ffwd函数对相同尺寸的图像进行批量处理
        ffwd(in_path_of_shape[shape], out_path_of_shape[shape],
             checkpoint_dir, device_t, batch_size)

def build_parser():
    parser = ArgumentParser()
    parser.add_argument('--checkpoint', type=str,
                        dest='checkpoint_dir',
                        help='dir or .ckpt file to load checkpoint from',
                        metavar='CHECKPOINT', required=False,
                        default=checkpoint_dir)

    parser.add_argument('--in-path', type=str,
                        dest='in_path',help='dir or file to transform',
                        metavar='IN_PATH', required=False,
                        default=in_dir)

    help_out = 'destination (dir or file) of transformed file or files'
    parser.add_argument('--out-path', type=str,
                        dest='out_path', help=help_out, metavar='OUT_PATH',
                        required=False,
                        default=out_dir)

    parser.add_argument('--device', type=str,
                        dest='device',help='device to perform compute on',
                        metavar='DEVICE', default=DEVICE)

    parser.add_argument('--batch-size', type=int,
                        dest='batch_size',help='batch size for feedforwarding',
                        metavar='BATCH_SIZE', default=BATCH_SIZE)

    parser.add_argument('--allow-different-dimensions', action='store_true',
                        dest='allow_different_dimensions',
                        help='allow different image dimensions')

    return parser

# 检查一个文件或目录是否存在
def exists(path, error_msg):
    if not os.path.exists(path):
        raise ValueError(error_msg)


def check_opts(opts):
    # 检查检查点目录是否存在
    exists(opts.checkpoint_dir, 'Checkpoint directory not found!')

    # 检查输入路径是否存在
    exists(opts.in_path, 'Input path not found!')

    # 检查输出路径，这里我们不直接检查它是否存在，因为可能程序会创建它
    # 如果需要确保输出目录存在且可写，可以添加相关逻辑
    # 但如果输出路径是一个文件而不是目录，则这里不应该有任何检查

    # 确保批处理大小大于0
    assert opts.batch_size > 0, "Batch size must be greater than 0"


def main():
    # 构建命令行参数解析器
    parser = build_parser()
    # 解析命令行参数到opts对象
    opts = parser.parse_args()
    # 检查命令行参数是否有效
    check_opts(opts)

    # 如果输入路径不是一个目录（即它是一个文件）
    if not os.path.isdir(opts.in_path):
        # 如果输出路径已存在且是一个目录
        if os.path.exists(opts.out_path) and os.path.isdir(opts.out_path):
            # 设置输出路径为输出目录下的输入文件名的同名目录或文件（取决于后续操作）
            out_path = os.path.join(opts.out_path, os.path.basename(opts.in_path))
        else:
            # 否则直接使用输出路径（可能是文件或目录）
            out_path = opts.out_path

            # 对单个文件执行前向传递并保存为图像
        ffwd_to_img(opts.in_path, out_path, opts.checkpoint_dir, device=opts.device)
    else:
        # 如果输入路径是一个目录
        files = list_files(opts.in_path)  # 列出目录下的所有文件
        full_in = [os.path.join(opts.in_path, x) for x in files]  # 构造完整的输入文件路径列表
        full_out = [os.path.join(opts.out_path, x) for x in files]  # 构造对应的输出文件路径列表

        # 根据是否允许不同尺寸的文件执行不同的前向传递函数
        if opts.allow_different_dimensions:
            # 如果允许不同尺寸，则使用不同的函数来处理这些文件
            ffwd_different_dimensions(full_in, full_out, opts.checkpoint_dir,
                                      device_t=opts.device, batch_size=opts.batch_size)
        else:
            # 如果不允许不同尺寸，则使用常规的前向传递函数来处理这些文件
            ffwd(full_in, full_out, opts.checkpoint_dir, device_t=opts.device,
                 batch_size=opts.batch_size)

from flask import Flask, request, jsonify, send_file, send_from_directory
from flask_cors import CORS
app = Flask(__name__)
CORS(app)
# # app.config内的配置名均为固定搭配
# # 储存上传的文件的地方
# app.config['UPLOAD_FOLDER'] = 'uploads/'
# # 允许的文件类型的集合
# app.config['ALLOWED_EXTENSIONS'] = set([ 'ckpt'])
# # 上传文件限制为最大 16MB，如果请求传输一个更大的文件， Flask 会抛出一个 RequestEntityTooLarge 异常。
# app.config['MAX_CONTENT_LENGTH'] = 50 * 1024 * 1024

def allowed_file(filename):
    """
    判断传入的文件后缀是否合规。不合规返回False
    :param filename:
    :return: True or False
    """
    return '.' in filename and filename.rsplit('.', 1)[1] in app.config['ALLOWED_EXTENSIONS']

@app.route('/predict2', methods=['POST'])
def upload():
    print("..................")
    # print(request.files)

    file = request.files['image']
    weight_file = request.form.get('selectedOption')

    global checkpoint_dir
    if weight_file=='Option1':
        checkpoint_dir = '../checkpoints/la_muse.ckpt'
    if weight_file=='Option2':
        checkpoint_dir = '../checkpoints/rain_princess.ckpt'
    if weight_file=='Option3':
        checkpoint_dir = '../checkpoints/scream.ckpt'
    if weight_file=='Option4':
        checkpoint_dir = '../checkpoints/udnie.ckpt'
    if weight_file=='Option5':
        checkpoint_dir = '../checkpoints/wave.ckpt'
    if weight_file=='Option6':
        checkpoint_dir = '../checkpoints/wreck.ckpt'


    file.save('../input_img/' + file.filename)
    # global checkpoint_dir
    # checkpoint_dir = '../checkpoints/' + weight_file.filename

    global in_dir
    in_dir = '../input_img/' + file.filename

    # 图像输出路径
    global out_dir
    out_dir = '../output_img/' + file.filename

    # 图像名字
    global out_path
    out_path= file.filename

    # 调用main函数处理图片
    main()

    # 将图片进行64位编码
    with open(out_dir, "rb") as img_file:
        encoded_string = base64.b64encode(img_file.read()).decode('utf-8')

    # 返回给前端
    return jsonify({'image': encoded_string, 'prediction': '你的转化结果'})


if __name__ == '__main__':
    app.run(
        host="127.0.0.1",
        port=int("9300"),
        debug=True
    )

