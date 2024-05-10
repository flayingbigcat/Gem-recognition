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

import base64
import os

import numpy as np
import requests
from flask import Flask, request, jsonify, send_from_directory, send_file
from flask_cors import CORS
from PIL import Image, PngImagePlugin
import MySQLdb
from multiprocessing.pool import ThreadPool

from ultralytics import YOLO
import io
import time

app = Flask(__name__)
CORS(app)
# 设置静态文件目录
app.static_folder = 'IMG/Save_gem/img_to_img'

# 注册静态文件目录
@app.route('/IMG/Save_gem/img_to_img/<path:filename>')
def get_image(filename):
    return send_from_directory(app.static_folder, filename)

url = "http://0.0.0.0:7860"

UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

payload = {
    # "prompt": "pandas eating bamboo, ..., (photorealistic:1.4),",
    "prompt": "a panda eating bamboo, ..., ",
    "negative_prompt":"EasyNegative, bad-hands-5, paintings, sketches, (worst quality:2), ..., NSFW, child, childish",
    "steps": 20,
    "width": 512,
    "height": 512,
    "restore_faces": True
}

# 定义图片上传目录
UPLOAD_FOLDER_CAROUSEL = 'IMG/CrouselImage'
UPLOAD_FOLDER_PRODUCT = 'IMG/Productimages'
UPLOAD_FOLDER_GEM = 'IMG/Gem_img'
UPLOAD_FOLDER_CREATE = 'IMG/Save_gem/img_to_img'

# MySQL 连接配置

conn = MySQLdb.connect(
    host='localhost',
    port=3306,
    user='root',
    passwd='root',
    db='web',
)

# 最大连接数
MAX_CONNECTIONS = 5

# 创建线程池
pool = ThreadPool(processes=MAX_CONNECTIONS)
#  测试数据库连接
# def test_db_connection():
#     try:
#         # conn = MySQLdb.connection
#         cur = conn.cursor()
#         cur.execute('SELECT * from users1')
#         result = cur.fetchone()
#         cur.close()
#         return result
#     except Exception as e:
#         return str(e)

@app.route('/get_images', methods=['GET'])
def get_images_test():
    # 获取完整的服务器地址
    server_url = request.host_url

    # 从数据库加载输出图片的文件名
    cur = conn.cursor()
    cur.execute("SELECT img_url FROM create_img")
    img_rows = cur.fetchall()

    # 构建输出图片的完整 URL 列表
    output_image_urls = [server_url + row[0] for row in img_rows]

    # 从数据库加载图片创建时间
    cur.execute("SELECT create_img_time FROM create_img")
    time_rows = cur.fetchall()
    # 构建输出图片的创建时间列表
    create_times = [row[0] for row in time_rows]

    cur.execute("SELECT create_img_time, prompt, negative_prompt, steps, height, width FROM create_img")
    data_prompt = cur.fetchall()
    output_prompt = [row for row in data_prompt]

    # 返回包含输出图片 URL 和创建时间的 JSON 响应
    response_data = {'output_image_urls': output_image_urls, 'create_times': create_times, 'all_data': output_prompt}
    return jsonify(response_data)


#定义路由
@app.route('/get_shops', methods=['GET'])
def get_shops():
    query_type = request.args.get('query_type')

    cur = conn.cursor()
    if query_type == 'all':
        cur.execute("SELECT * FROM shop")
    elif query_type == 'by_id':
        product_id = request.args.get('product_id')
        cur.execute("SELECT * FROM shop WHERE product_id=%s", (product_id,))
    elif query_type == 'by_name':
        product_name = request.args.get('product_name')
        cur.execute("SELECT * FROM shop WHERE product_name=%s", (product_name,))
    elif query_type == 'top_9':
        cur.execute("SELECT * FROM shop LIMIT 9")
    else:
        return jsonify({'error': 'Invalid query_type'})

    shops = cur.fetchall()
    cur.close()
    return jsonify(shops)




# 处理文件编码的通用函数
def encode_images(folder_path):
    images_data = []
    for filename in os.listdir(folder_path):
        if filename.endswith('.jpg') or filename.endswith('.png') or filename.endswith('.jpeg'):
            file_path = os.path.join(folder_path, filename)
            with open(file_path, 'rb') as f:
                img_content = f.read()
            encoded_img = base64.b64encode(img_content).decode('utf-8')
            images_data.append(encoded_img)
    return images_data


@app.route('/uploadimg/carousel', methods=['GET'])
def upload_img_carousel():
    images_data = encode_images(UPLOAD_FOLDER_CAROUSEL)
    return jsonify(images_data), 200


@app.route('/uploadimg/product', methods=['GET'])
def upload_img_product():
    images_data = encode_images(UPLOAD_FOLDER_PRODUCT)
    return jsonify(images_data), 200

@app.route('/uploadimg/GEM', methods=['GET'])
def upload_img_Gem():
    images_data = encode_images(UPLOAD_FOLDER_GEM)
    return jsonify(images_data), 200

@app.route('/uploadimg/create', methods=['GET'])
def upload_create_Gem():
    images_data = encode_images(UPLOAD_FOLDER_CREATE)
    return jsonify(images_data), 200

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


@app.route('/generate', methods=['POST'])
def generate():


    # # Extract parameters from request
    steps = int(request.form['steps'])
    prompt = request.form['prompt']
    negative_prompt = request.form['negative_prompt']
    width = int(request.form['width'])
    height = int(request.form['height'])


    # Other parameters
    sampler_name = "DPM++ 2M"
    batch_size = 1
    restore_faces = False

    payload = {
        # "prompt": "pandas eating bamboo, ..., (photorealistic:1.4),",
        "prompt": prompt,
        "negative_prompt": negative_prompt,
        "steps": steps,
        "batch_size": batch_size,
        "width": width,
        "height": height,
        "restore_faces": restore_faces,
        "sampler_name":sampler_name,
    }

    # Generate image using text-to-image API
    response = requests.post(url=f'{url}/sdapi/v1/txt2img', json=payload)
    r = response.json()
    output_image = Image.open(io.BytesIO(base64.b64decode(r['images'][0])))

    # # Save output image
    # 创建唯一的文件名
    timestamp = int(time.time())
    output_filename = f'IMG/Save_gem/img_to_img/{timestamp}.png'

    # 保存输出图片
    output_image.save(output_filename)
    #
    # with open(output_image, "rb") as image_file:
    #     encoded_string = base64.b64encode(image_file.read()).decode('utf-8')
    # encoded_string = base64.b64encode(encoded_string.read()).decode('utf-8')

    # 获取完整的服务器地址
    server_url = request.host_url  # 获取服务器地址，例如：http://127.0.0.1:5000/

    # 构建输出图像的完整 URL
    output_image_url = server_url + output_filename
    print(output_image_url)

    # 返回包含图像 URL 的 JSON 响应
    return jsonify({'output_image_url': output_image_url})
    # for i in r['images']:
    #     generated_image = Image.open(io.BytesIO(base64.b64decode(i.split(",",1)[0])))
    #
    #     png_payload = {
    #         "image": "data:image/png;base64," + i
    #     }
    #     response2 = requests.post(url=f'{url}/sdapi/v1/png-info', json=png_payload)
    #
    #     PI = PngImagePlugin.PngInfo()
    #     PI.add_text("parameters", response2.json().get("info"))
    #
    #     # Save the generated image
    #     filename = 'generated_image.png'
    #     file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    #     # generated_image.save('generated_image.png', pnginfo=PI)
    #     generated_image.save(file_path, pnginfo=PI)
    #
    # # return jsonify({"generated_image_path": "generated_image.png"})
    #     # Encode the image as Base64
    #     with open(file_path, "rb") as img_file:
    #         base64_image = base64.b64encode(img_file.read()).decode("utf-8")
    #
    # return jsonify({"generated_image_base64": base64_image})

@app.route('/images/<filename>')
def get_text_image(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)

@app.route('/upload_image', methods=['POST'])
def upload_image():
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400

    file = request.files['image']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    # Read the uploaded image
    img = Image.open(file.stream)
    print(request.form)
    # Convert image to bytes
    img_byte_arr = io.BytesIO()
    img.save(img_byte_arr, format='PNG')
    img_byte_arr = img_byte_arr.getvalue()

    # Encode image to base64
    encoded_image = base64.b64encode(img_byte_arr).decode('utf-8')

    # # Extract parameters from request
    steps = int(request.form['steps'])
    prompt = request.form['prompt']
    negative_prompt = request.form['negative_prompt']
    width = int(request.form['width'])
    height = int(request.form['height'])

    # Other parameters
    sampler_name = "DPM++ 2M"
    batch_size = 1
    n_iter = 1
    seed = 1
    cfg_scale = 7
    CLIP_stop_at_last_layers = 2
    restore_faces = False

    # Construct payload
    payload = {
        "prompt": prompt,
        "negative_prompt": negative_prompt,
        "steps": steps,
        "sampler_name": sampler_name,
        "width": width,
        "height": height,
        "batch_size": batch_size,
        "n_iter": n_iter,
        "seed": seed,
        "cfg_scale": cfg_scale,
        "CLIP_stop_at_last_layers": CLIP_stop_at_last_layers,
        "init_images": [encoded_image],
        "restore_faces": restore_faces,
    }
    # 发送请求
    response = requests.post(url=f'http://0.0.0.0:7860/sdapi/v1/img2img', json=payload)
    r = response.json()
    output_image = Image.open(io.BytesIO(base64.b64decode(r['images'][0])))

    # 创建唯一的文件名
    timestamp = int(time.time())
    output_filename = f'IMG/Save_gem/img_to_img/{timestamp}.png'

    # 保存输出图片
    output_image.save(output_filename)

    # 获取完整的服务器地址
    server_url = request.host_url  # 获取服务器地址，例如：http://127.0.0.1:5000/

    # 构建输出图像的完整 URL
    output_image_url = server_url + output_filename
    print(output_image_url)
    #保存到数据库
    cur = conn.cursor()
    # 执行插入操作
    insert_query = "INSERT INTO create_img (create_img_time, img_url, prompt, negative_prompt, steps, height, width) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    cur.execute(insert_query, (time.strftime('%Y-%m-%d %H:%M:%S'), output_filename, prompt, negative_prompt, steps, height, width))
    conn.commit()

    # 返回包含图像 URL 的 JSON 响应
    return jsonify({'output_image_url': output_image_url})




if __name__ == '__main__':
    app.run(host="127.0.0.1", debug=True, port=9200)





