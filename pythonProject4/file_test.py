import os
import random
import shutil

def split_dataset(source_dir, target_dir, split_ratio=0.8):
    # 创建目标文件夹
    train_dir = os.path.join(target_dir, 'train')
    val_dir = os.path.join(target_dir, 'val')
    os.makedirs(train_dir, exist_ok=True)
    os.makedirs(val_dir, exist_ok=True)

    # 获取原始数据集类别
    categories = os.listdir(source_dir)

    # 遍历每个类别
    for category in categories:
        category_source_dir = os.path.join(source_dir, category)
        category_train_dir = os.path.join(train_dir, category)
        category_val_dir = os.path.join(val_dir, category)
        os.makedirs(category_train_dir, exist_ok=True)
        os.makedirs(category_val_dir, exist_ok=True)

        # 获取当前类别下的所有图像文件名
        files = os.listdir(category_source_dir)
        num_files = len(files)

        # 计算训练集和验证集的数量
        num_train = int(num_files * split_ratio)

        # 打乱文件顺序
        random.shuffle(files)

        # 复制图像到训练集和验证集文件夹
        for i, file in enumerate(files):
            source_file = os.path.join(category_source_dir, file)
            if i < num_train:
                target_file = os.path.join(category_train_dir, file)
            else:
                target_file = os.path.join(category_val_dir, file)
            shutil.copyfile(source_file, target_file)

    print("Dataset split completed.")

# 设置源数据集和目标数据集文件夹路径
source_dataset_dir = r"D:\迅雷下载\fruits\fruits"
target_dataset_dir = r"D:\yxz\yuzai_web\datasets_1"

# 拆分数据集
split_dataset(source_dataset_dir, target_dataset_dir)