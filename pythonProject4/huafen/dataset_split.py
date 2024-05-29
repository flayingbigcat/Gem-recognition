import os
import shutil
import random

def create_dir(directory):
    if not os.path.exists(directory):
        os.makedirs(directory)

# 路径配置
image_folder = r'D:\迅雷下载\fruits\fruits'
annotation_folder = r'D:\迅雷下载\fruits\anntations'
train_image_folder = r'D:\迅雷下载\fruits\dataset\train_images'
train_annotation_folder = r'D:\迅雷下载\fruits\dataset\train_annotations'
val_image_folder = r'D:\迅雷下载\fruits\dataset\val_images'
val_annotation_folder = r'D:\迅雷下载\fruits\dataset\val_annotations'

# 创建训练和验证文件夹
create_dir(train_image_folder)
create_dir(train_annotation_folder)
create_dir(val_image_folder)
create_dir(val_annotation_folder)

# 获取所有的标注文件名
annotation_files = [f for f in os.listdir(annotation_folder) if f.endswith('.txt')]

# 打乱文件顺序
random.shuffle(annotation_files)

# 计算划分索引
num_files = len(annotation_files)
split_index = int(num_files * 0.8)

# 划分训练和验证文件
train_files = annotation_files[:split_index]
val_files = annotation_files[split_index:]

# 复制文件函数
def copy_files(files, src_img_folder, src_anno_folder, dest_img_folder, dest_anno_folder):
    for anno_file in files:
        # 获取对应的图像文件名
        img_file = anno_file.replace('.txt', '.jpg')

        # 源文件路径
        src_img_path = os.path.join(src_img_folder, img_file)
        src_anno_path = os.path.join(src_anno_folder, anno_file)

        # 目标文件路径
        dest_img_path = os.path.join(dest_img_folder, img_file)
        dest_anno_path = os.path.join(dest_anno_folder, anno_file)

        # 复制文件
        if os.path.exists(src_img_path) and os.path.exists(src_anno_path):
            shutil.copy(src_img_path, dest_img_path)
            shutil.copy(src_anno_path, dest_anno_path)
        else:
            print(f"文件 {anno_file} 或 {img_file} 不存在，跳过。")

# 复制训练数据
copy_files(train_files, image_folder, annotation_folder, train_image_folder, train_annotation_folder)

# 复制验证数据
copy_files(val_files, image_folder, annotation_folder, val_image_folder, val_annotation_folder)

print("数据集划分完成。")
