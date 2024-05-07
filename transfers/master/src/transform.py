# 导入 TensorFlow 和 pdb（Python 的调试器，但在这段代码中并未使用）
import tensorflow as tf, pdb

# 初始化权重的标准差
WEIGHTS_INIT_STDEV = .1


# 定义主网络结构
def net(image):
    # 通过一系列的卷积层
    conv1 = _conv_layer(image, 32, 9, 1)  # 第一个卷积层，32个滤波器，9x9大小，步长为1
    conv2 = _conv_layer(conv1, 64, 3, 2)  # 第二个卷积层，64个滤波器，3x3大小，步长为2
    conv3 = _conv_layer(conv2, 128, 3, 2)  # 第三个卷积层，128个滤波器，3x3大小，步长为2

    # 通过一系列的残差块
    resid1 = _residual_block(conv3, 3)  # 第一个残差块，滤波器大小为3
    resid2 = _residual_block(resid1, 3)
    resid3 = _residual_block(resid2, 3)
    resid4 = _residual_block(resid3, 3)
    resid5 = _residual_block(resid4, 3)

    # 通过一系列的转置卷积层进行上采样
    conv_t1 = _conv_tranpose_layer(resid5, 64, 3, 2)  # 第一个转置卷积层，64个滤波器，3x3大小，步长为2
    conv_t2 = _conv_tranpose_layer(conv_t1, 32, 3, 2)  # 第二个转置卷积层，32个滤波器，3x3大小，步长为2

    # 最后的卷积层，不使用 ReLU 激活函数
    conv_t3 = _conv_layer(conv_t2, 3, 9, 1, relu=False)  # 最后一个卷积层，3个滤波器，9x9大小，步长为1

    # 预测输出，使用双曲正切函数进行归一化并线性变换到 0-255 的范围
    preds = tf.nn.tanh(conv_t3) * 150 + 255. / 2
    return preds


# 定义卷积层
def _conv_layer(net, num_filters, filter_size, strides, relu=True):
    # 初始化权重
    weights_init = _conv_init_vars(net, num_filters, filter_size)  # 注意这里调用了 _conv_init_vars 函数，但该函数在给定的代码片段中未定义

    # 设置卷积的步长
    strides_shape = [1, strides, strides, 1]

    # 进行卷积操作
    net = tf.nn.conv2d(net, weights_init, strides_shape, padding='SAME')

    # 对卷积结果进行实例归一化
    net = _instance_norm(net)  # 注意这里调用了 _instance_norm 函数，但该函数在给定的代码片段中未定义

    # 如果需要，则添加 ReLU 激活函数
    if relu:
        net = tf.nn.relu(net)

    return net


def _conv_tranpose_layer(net, num_filters, filter_size, strides):
    weights_init = _conv_init_vars(net, num_filters, filter_size, transpose=True)

    batch_size, rows, cols, in_channels = [i.value for i in net.get_shape()]
    new_rows, new_cols = int(rows * strides), int(cols * strides)
    # new_shape = #tf.pack([tf.shape(net)[0], new_rows, new_cols, num_filters])

    new_shape = [batch_size, new_rows, new_cols, num_filters]
    tf_shape = tf.stack(new_shape)
    strides_shape = [1,strides,strides,1]

    net = tf.nn.conv2d_transpose(net, weights_init, tf_shape, strides_shape, padding='SAME')
    net = _instance_norm(net)
    return tf.nn.relu(net)

def _residual_block(net, filter_size=3):
    tmp = _conv_layer(net, 128, filter_size, 1)
    return net + _conv_layer(tmp, 128, filter_size, 1, relu=False)

def _instance_norm(net, train=True):
    batch, rows, cols, channels = [i.value for i in net.get_shape()]
    var_shape = [channels]
    mu, sigma_sq = tf.nn.moments(net, [1,2], keep_dims=True)
    shift = tf.Variable(tf.zeros(var_shape))
    scale = tf.Variable(tf.ones(var_shape))
    epsilon = 1e-3
    normalized = (net-mu)/(sigma_sq + epsilon)**(.5)
    return scale * normalized + shift

def _conv_init_vars(net, out_channels, filter_size, transpose=False):
    _, rows, cols, in_channels = [i.value for i in net.get_shape()]
    if not transpose:
        weights_shape = [filter_size, filter_size, in_channels, out_channels]
    else:
        weights_shape = [filter_size, filter_size, out_channels, in_channels]

    weights_init = tf.Variable(tf.truncated_normal(weights_shape, stddev=WEIGHTS_INIT_STDEV, seed=1), dtype=tf.float32)
    return weights_init
