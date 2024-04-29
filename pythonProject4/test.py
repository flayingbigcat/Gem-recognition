# from ultralytics import YOLO
#
# model = YOLO('./best.pt')
#
# results = model('D:\\yxz\\yuzai_web\\archive_train\\Pearl\\pearl_1.jpg', device='cpu')
# print(results[0].probs)

#
# print(results)
# import os
# import random
# import shutil
#
# def split_dataset(source_dir, target_dir, split_ratio=0.8):
#     # 创建目标文件夹
#     train_dir = os.path.join(target_dir, 'train')
#     val_dir = os.path.join(target_dir, 'val')
#     os.makedirs(train_dir, exist_ok=True)
#     os.makedirs(val_dir, exist_ok=True)
#
#     # 获取原始数据集类别
#     categories = os.listdir(source_dir)
#
#     # 遍历每个类别
#     for category in categories:
#         category_source_dir = os.path.join(source_dir, category)
#         category_train_dir = os.path.join(train_dir, category)
#         category_val_dir = os.path.join(val_dir, category)
#         os.makedirs(category_train_dir, exist_ok=True)
#         os.makedirs(category_val_dir, exist_ok=True)
#
#         # 获取当前类别下的所有图像文件名
#         files = os.listdir(category_source_dir)
#         num_files = len(files)
#
#         # 计算训练集和验证集的数量
#         num_train = int(num_files * split_ratio)
#
#         # 打乱文件顺序
#         random.shuffle(files)
#
#         # 复制图像到训练集和验证集文件夹
#         for i, file in enumerate(files):
#             source_file = os.path.join(category_source_dir, file)
#             if i < num_train:
#                 target_file = os.path.join(category_train_dir, file)
#             else:
#                 target_file = os.path.join(category_val_dir, file)
#             shutil.copyfile(source_file, target_file)
#
#     print("Dataset split completed.")
#
# # 设置源数据集和目标数据集文件夹路径
# source_dataset_dir = r"D:\yxz\yuzai_web\archive_train"
# target_dataset_dir = r"D:\yxz\yuzai_web\datasets"
#
# # 拆分数据集
# split_dataset(source_dataset_dir, target_dataset_dir)

import numpy as np
from flask import Flask, request, jsonify
from flask_cors import CORS
from PIL import Image
from ultralytics import YOLO

app = Flask(__name__)
CORS(app)

@app.route('/predict', methods=['POST'])
def predict():
    # 从请求中获取图像文件
    img_file = request.files['image']

    # 加载 YOLO 模型
    model = YOLO('./best.pt')

    # 使用 PIL（Python Imaging Library）打开图像文件
    image = Image.open(img_file)

    # 如果图像不是 RGB 格式，则转换为 RGB 格式
    image = image.convert('RGB')

    # 对图像进行目标检测
    results = model(image)
    # 去模型炼出的金丹
    class_name = results[0].names[results[0].probs.top1]

    return class_name
# # ?调试输出检测结果的类型和内容
# print("Results type:", type(results))
# print("Results content:", results)
#     detected_objects = []
#     detected_objects.append({'class_name': results[0].names[results[0].probs.top1], 'confidence': results[0].probs.top1conf.item()})

    # # 将检测到的对象类别和置信度返回给前端
    # return jsonify({'detected_objects': detected_objects})


if __name__ == '__main__':
    app.run(host="127.0.0.1", debug=True, port=9200)





