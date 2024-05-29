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
import urllib
from urllib.parse import unquote, urlparse
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

# 用参数<folder>来接收IMG不同文件夹的图片
@app.route('/IMG/<folder>/<path:filename>')
def get_image_tset(folder, filename):
    # 解码含有%20的文件名
    filename = urllib.parse.unquote(filename)
    folder_path = f'IMG/{folder}'
    return send_from_directory(folder_path, filename)

url = "http://127.0.0.1:7860"

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
UPLOAD_FOLDER_PRODUCT1 = 'IMG\\Product_img'
app.config['UPLOAD_FOLDER_PRODUCT1'] = UPLOAD_FOLDER_PRODUCT1
UPLOAD_FOLDER_CAROUSEL = 'IMG/CrouselImage'
UPLOAD_FOLDER_PRODUCT = 'IMG/Productimages'
UPLOAD_FOLDER_GEM = 'IMG/Gem_img'
UPLOAD_FOLDER_CREATE = 'IMG/Save_gem/img_to_img'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

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

@app.route('/login', methods=['POST'])
def login():

    user_email = request.get_json()['user_email']
    user_password = request.get_json()['user_password']
    # 查询数据库中是否存在匹配的用户
    with conn.cursor() as cursor:
        sql = "SELECT user_id,user_email, user_password FROM users1 WHERE user_email = %s AND user_password = %s"
        cursor.execute(sql, (user_email, user_password))
        user = cursor.fetchone()  # 获取一条用户记录
        print(user)

    if user:
        user_id = user[0]  # 获取用户的 user_id
        # 返回登录成功的响应，包含用户的 user_id
        return jsonify({'status': 'success', 'user_id': user_id}), 200
    else:
        # 返回登录失败的响应
        return jsonify({'status': 'fail', 'message': '用户名或密码错误'}), 401

@app.route('/SignUp', methods=['POST'])
def register():
    # 获取注册信息
    user_name = request.get_json()['user_name']
    user_password = request.get_json()['user_password']
    user_email = request.get_json()['user_email']

    # 检查用户名是否已经存在
    with conn.cursor() as cursor:
        sql = "SELECT * FROM users1 WHERE user_name = %s"
        cursor.execute(sql, (user_name,))
        existing_user = cursor.fetchone()

    if existing_user:
        # 如果用户名已经存在，则返回注册失败的响应
        return jsonify({'status': 'fail', 'message': '用户名已存在'}), 400
    else:
        # 将新用户插入数据库
        with conn.cursor() as cursor:
            sql = "INSERT INTO users1 (user_name, user_password,user_email) VALUES (%s, %s,%s)"
            cursor.execute(sql, (user_name, user_password, user_email))
            conn.commit()

        # 返回注册成功的响应
        return jsonify({'status': 'success', 'message': '注册成功'}), 201

# 根据用户ID查询用户信息的接口
@app.route('/selectUser', methods=['GET'])  # 定义路由 '/selectUser'，处理 GET 请求
def select_user():
    user_id = request.args.get('id')  # 获取 URL 参数中的用户ID
    try:
        with conn.cursor() as cursor:
            # 查询数据库中用户信息，排除密码字段
            sql = "SELECT user_id, user_name, user_email, user_phone, user_address, user_sex, user_description, user_imageSrc FROM users1 WHERE user_id = %s"
            cursor.execute(sql, user_id)  # 执行查询
            user = cursor.fetchone()  # 获取查询结果的第一条数据
            print(user)
            if user:
                return jsonify(user)  # 将用户信息以 JSON 格式返回给前端
            else:
                return jsonify({'error': '没有该用户'}), 404  # 若未找到用户，返回错误信息
    except Exception as e:
        return jsonify({'error': str(e)}), 500  # 若发生异常，返回异常信息


@app.route('/reviseUser', methods=['POST'])
def revise_user():
    try:
        user_data = request.json

        print(user_data)

        cur = conn.cursor()
        update_query = """UPDATE users1 SET user_name=%s, user_email=%s, user_address=%s, user_phone=%s, user_sex=%s, user_description=%s, user_imageSrc=%s WHERE user_id=%s"""
        cur.execute(update_query, (user_data['user_name'], user_data['user_email'], user_data['user_address'], user_data['user_phone'], user_data['user_sex'], user_data['user_description'], user_data['user_imageSrc'], user_data['user_id']))
        # 提交事务
        conn.commit()

        return '', 204
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/get_images', methods=['GET'])
def get_images_test():
    # 获取完整的服务器地址
    server_url = request.host_url

    # 从请求中获取用户ID
    user_id = request.args.get('user_id')

    # 从数据库加载输出图片的文件名
    cur = conn.cursor()
    cur.execute("SELECT img_url FROM create_img WHERE user_id = %s", (user_id,))
    img_rows = cur.fetchall()

    # 构建输出图片的完整 URL 列表
    output_image_urls = [server_url + row[0] for row in img_rows]

    # 从数据库加载数据
    cur.execute("SELECT * FROM create_img WHERE user_id = %s", (user_id,))
    data_prompt = cur.fetchall()
    output_prompt = [row for row in data_prompt]

    # 返回包含输出图片 URL 和创建时间的 JSON 响应
    response_data = {'output_image_urls': output_image_urls, 'all_data': output_prompt}
    return jsonify(response_data)


#定义路由
@app.route('/get_shops', methods=['GET'])
def get_shops():
    query_type = request.args.get('query_type')

    cur = conn.cursor()
    if query_type == 'all':
        cur.execute("SELECT product_id, product_name, product_imageSrc ,product_price FROM shop")
    elif query_type == 'by_id':
        product_id = request.args.get('product_id')
        print(product_id)
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

@app.route('/get_aishops', methods=['GET'])
def get_ai_shops():
    query_type = request.args.get('query_type')

    cur = conn.cursor()
    if query_type == 'all':
        cur.execute("SELECT product_id, product_name, product_imageSrc ,product_price FROM shop_copy")
    elif query_type == 'by_id':
        product_id = request.args.get('product_id')
        print(product_id)
        cur.execute("SELECT * FROM shop_copy WHERE product_id=%s", (product_id,))
    elif query_type == 'by_name':
        product_name = request.args.get('product_name')
        cur.execute("SELECT * FROM shop_copy WHERE product_name=%s", (product_name,))
    elif query_type == 'top_9':
        cur.execute("SELECT * FROM shop_copy LIMIT 9")
    else:
        return jsonify({'error': 'Invalid query_type'})

    shops = cur.fetchall()
    cur.close()
    return jsonify(shops)

@app.route('/searchShop', methods=['POST'])
def search_shop():
    # 获取前端发送的产品名称
    product_name = request.json.get('productName')

    # 查询数据库中是否存在匹配的产品
    with conn.cursor() as cursor:
        sql = "SELECT product_id FROM shop WHERE product_name = %s"
        cursor.execute(sql, (product_name,))
        product = cursor.fetchone()  # 获取一条产品记录

    if product:
        # 如果找到匹配的产品，返回产品 ID
        product_id = product[0]
        print(product_id)
        return jsonify({'product_id': product_id}), 200
    else:
        # 如果未找到匹配的产品，返回空结果
        return jsonify({'product_id': None}), 404

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/uploadProduct', methods=['POST'])
def upload_product():
    # 初始 product_id 值
    product_id_counter = 100
    try:
        # 获取表单数据
        user_id = request.form.get('user_id')
        product_name = request.form.get('product_name')
        product_description = request.form.get('product_description')
        product_price = request.form.get('product_price')
        seller_email = request.form.get('seller_email')
        seller_phone = request.form.get('seller_phone')
        shipping_address = request.form.get('shipping_address')

        # 获取当前 Flask 应用的 IP 和端口号
        host = request.host_url

        image_urls = []

        # 处理文件上传
        for file_key in request.files:
            file = request.files[file_key]
            if file and allowed_file(file.filename):
                current_time = int(time.time())  # 获取当前时间戳
                filename_without_extension, file_extension = os.path.splitext(file.filename)  # 获取文件名和扩展名
                unique_filename = f"{filename_without_extension}_{current_time}{file_extension}"  # 将当前时间戳加到文件名中
                file_path = os.path.join(app.config['UPLOAD_FOLDER_PRODUCT1'], unique_filename)
                file.save(file_path)
                standardized_file_path = file_path.replace('\\', '/')
                image_urls.append(host + standardized_file_path)
            else:
                return jsonify({'error': 'File type not allowed'}), 400

        # 分配 URL 给不同的字段
        product_imageSrc = image_urls[0] if len(image_urls) > 0 else None
        product_imageSrc1 = image_urls[1] if len(image_urls) > 1 else None
        product_imageSrc2 = image_urls[2] if len(image_urls) > 2 else None

        cur = conn.cursor()
        try:
            # 检查是否存在相同的 product_name 和 user_id
            cur.execute("SELECT product_id FROM shop WHERE product_name = %s AND user_id = %s",
                        (product_name, user_id))
            existing_product = cur.fetchone()

            if existing_product:
                product_id = existing_product[0]
                print(product_id)
                # 更新已有记录
                sql = """
                UPDATE shop SET product_price = %s, product_imageSrc = %s,
                product_description = %s, product_imageSrc2 = %s, product_imageSrc1 = %s
                WHERE product_id = %s
                """
                cur.execute(sql, (product_price, product_imageSrc, product_description,
                                  product_imageSrc2, product_imageSrc1, product_id))

                sql1 = """
                UPDATE seller_copy SET seller_email = %s, seller_phone = %s, shipping_address = %s
                WHERE product_id = %s
                """
                cur.execute(sql1, (seller_email, seller_phone, shipping_address, product_id))
            else:
                # 获取当前最大 product_id
                cur.execute("SELECT MAX(product_id) FROM shop")
                max_product_id = cur.fetchone()[0]
                print(max_product_id)
                if max_product_id is None:
                    max_product_id = 100
                else:
                    max_product_id += 1

                # 插入新记录
                sql = """
                INSERT INTO shop (product_id, product_name, product_price, product_imageSrc,
                product_description, product_imageSrc2, product_imageSrc1, user_id)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """
                cur.execute(sql, (max_product_id, product_name, product_price, product_imageSrc, product_description,
                                  product_imageSrc2, product_imageSrc1, user_id))

                sql1 = """
                INSERT INTO seller_copy (product_id, product_name, seller_email, seller_phone, 
                shipping_address, user_id)
                VALUES (%s, %s, %s, %s, %s, %s)
                """
                cur.execute(sql1, (max_product_id, product_name, seller_email, seller_phone, shipping_address, user_id))

            conn.commit()
        except Exception as e:
            conn.rollback()
            app.logger.error(f"Database operation failed: {str(e)}")
            return jsonify({'error': str(e)}), 500
        finally:
            cur.close()

        print(user_id, product_name, product_description, product_price,
              seller_email, seller_phone, shipping_address, product_imageSrc, product_imageSrc1, product_imageSrc2)

        return jsonify({'message': 'Product uploaded successfully'}), 201
    except Exception as e:
        conn.rollback()
        return jsonify({'error': str(e)}), 500

@app.route('/uploadAIProduct', methods=['POST'])
def upload_ai_product():
    # 初始 product_id 值
    try:
        # 获取表单数据
        user_id = request.form.get('user_id')
        product_name = request.form.get('product_name')
        product_description = request.form.get('product_description')
        product_price = request.form.get('product_price')
        seller_email = request.form.get('seller_email')
        seller_phone = request.form.get('seller_phone')
        shipping_address = request.form.get('shipping_address')

        # 获取当前 Flask 应用的 IP 和端口号
        host = request.host_url

        image_urls = []

        # 处理文件上传
        for file_key in request.files:
            file = request.files[file_key]
            if file and allowed_file(file.filename):
                current_time = int(time.time())  # 获取当前时间戳
                filename_without_extension, file_extension = os.path.splitext(file.filename)  # 获取文件名和扩展名
                unique_filename = f"{filename_without_extension}_{current_time}{file_extension}"  # 将当前时间戳加到文件名中
                file_path = os.path.join(app.config['UPLOAD_FOLDER_PRODUCT1'], unique_filename)
                file.save(file_path)
                standardized_file_path = file_path.replace('\\', '/')
                image_urls.append(host + standardized_file_path)
            else:
                return jsonify({'error': 'File type not allowed'}), 400

        # 分配 URL 给不同的字段
        product_imageSrc = image_urls[0] if len(image_urls) > 0 else None
        product_imageSrc1 = image_urls[1] if len(image_urls) > 1 else None
        product_imageSrc2 = image_urls[2] if len(image_urls) > 2 else None

        cur = conn.cursor()
        try:
            # 检查是否存在相同的 product_name 和 user_id
            cur.execute("SELECT product_id FROM shop_copy WHERE product_name = %s AND user_id = %s",
                        (product_name, user_id))
            existing_product = cur.fetchone()

            if existing_product:
                product_id = existing_product[0]
                # 更新已有记录
                sql = """
                UPDATE shop_copy SET product_price = %s, product_imageSrc = %s,
                product_description = %s, product_imageSrc2 = %s, product_imageSrc1 = %s
                WHERE product_id = %s
                """
                cur.execute(sql, (product_price, product_imageSrc, product_description,
                                  product_imageSrc2, product_imageSrc1, product_id))

                sql1 = """
                UPDATE seller SET seller_email = %s, seller_phone = %s, shipping_address = %s
                WHERE product_id = %s
                """
                cur.execute(sql1, (seller_email, seller_phone, shipping_address, product_id))
            else:
                # 查询当前最大的 product_id 值
                cur.execute("SELECT MAX(product_id) FROM shop_copy")
                max_product_id = cur.fetchone()[0]

                # 如果没有记录，则将 max_product_id 设为 100
                if max_product_id is None:
                    max_product_id = 100
                else:
                    # 检查最大 product_id 是否以 "gem_" 开头
                    if max_product_id.startswith("gem_"):
                        # 提取出数字部分，并加1
                        number_part = int(max_product_id.split("_")[1])
                        max_product_id = f"gem_{number_part + 1}"
                    else:
                        # 直接加1，并添加 "gem_" 前缀
                        max_product_id = f"gem_{max_product_id + 1}"

                # 插入新记录
                sql = """
                INSERT INTO shop_copy (product_id, product_name, product_price, product_imageSrc, product_description,
                 product_imageSrc2, product_imageSrc1, user_id)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s);
                """
                cur.execute(sql, (max_product_id, product_name, product_price, product_imageSrc, product_description,
                                  product_imageSrc2, product_imageSrc1, user_id))

                sql1 = """
                INSERT INTO seller (product_id, product_name, seller_email, seller_phone, shipping_address, user_id)
                VALUES (%s, %s, %s, %s, %s, %s)
                """
                cur.execute(sql1, (max_product_id, product_name, seller_email, seller_phone, shipping_address, user_id))

            conn.commit()
        except Exception as e:
            conn.rollback()
            app.logger.error(f"Database operation failed: {str(e)}")
            return jsonify({'error': str(e)}), 500
        finally:
            cur.close()

        print(user_id, product_name, product_description, product_price,
              seller_email, seller_phone, shipping_address, product_imageSrc, product_imageSrc1, product_imageSrc2)

        return jsonify({'message': 'Product uploaded successfully'}), 201
    except Exception as e:
        app.logger.error(f"General error: {str(e)}")
        conn.rollback()
        return jsonify({'error': str(e)}), 500

@app.route('/getProducts', methods=['GET'])
def get_products():
    try:
        user_id = request.args.get('user_id')  # 获取 URL 参数中的用户ID

        with conn.cursor() as cursor:
            # 查询数据库中用户的产品信息
            sql = """
            (SELECT product_id, product_name, product_price, product_time, product_imageSrc FROM shop WHERE user_id = %s)
            UNION
            (SELECT product_id, product_name, product_price, product_time, product_imageSrc FROM shop_copy WHERE user_id = %s)
            """
            cursor.execute(sql, (user_id, user_id))  # 执行查询
            products = cursor.fetchall()  # 获取查询结果的所有数据
            print(products)

            if products:
                return jsonify(products)  # 将产品信息以 JSON 格式返回给前端
            else:
                return jsonify({'error': 'No products found for the user'}), 404  # 若未找到产品信息，返回错误信息
    except Exception as e:
        return jsonify({'error': str(e)}), 500  # 若发生异常，返回异常信息

@app.route('/getcartProducts', methods=['GET'])
def get_cart_products():
    try:
        user_id = request.args.get('user_id')  # 获取 URL 参数中的用户ID
        print(user_id)

        with conn.cursor() as cursor:
            # 查询数据库中用户的产品信息
            sql = """
            (SELECT product_id, product_name, product_price, create_time, product_imageSrc 
            FROM user_cart WHERE user_id = %s)
            UNION
            (SELECT product_id, product_name, product_price, create_time, product_imageSrc 
            FROM user_cart_copy WHERE user_id = %s)
            """
            cursor.execute(sql, (user_id, user_id))  # 执行查询
            products = cursor.fetchall()  # 获取查询结果的所有数据
            print(products)

            if products:
                return jsonify(products)  # 将产品信息以 JSON 格式返回给前端
            else:
                return jsonify({'error': 'No products found for the user'}), 404  # 若未找到产品信息，返回错误信息
    except Exception as e:
        app.logger.error(f"General error: {str(e)}")
        conn.rollback()
        return jsonify({'error': str(e)}), 500  # 若发生异常，返回异常信息

@app.route('/add_to_cart', methods=['POST'])
def add_to_cart():
    data = request.get_json()
    product_id = data.get('product_id')
    product_name = data.get('product_name')
    product_price = data.get('product_price')
    user_id = data.get('user_id')
    product_image_src = data.get('product_imageSrc')
    print(product_id, product_name, product_price, user_id, product_image_src)

    if not (product_id and product_name and product_price and user_id):
        return jsonify({'error': 'Missing required parameters'}), 400

    try:
        cur = conn.cursor()

        # 根据 product_id 的值选择查询的表
        if str(product_id).startswith('gem_'):  # 将 product_id 转换为字符串后再调用 startswith 方法
            table_name = 'user_cart_copy'
        else:
            table_name = 'user_cart'

        # 检查是否已经存在相同的 product_id 和 user_id 的记录
        check_query = f"SELECT COUNT(*) FROM {table_name} WHERE product_id = %s AND user_id = %s"
        cur.execute(check_query, (product_id, user_id))
        result = cur.fetchone()

        if result[0] > 0:
            return jsonify({'error': 'This item is already in the cart'}), 400

        # 插入记录到相应的表中
        insert_query = (f"INSERT INTO {table_name} (product_id, product_name, product_price, user_id, product_imageSrc) "
                        f"VALUES (%s, %s, %s, %s, %s)")
        cur.execute(insert_query, (product_id, product_name, product_price, user_id, product_image_src))
        conn.commit()

        return jsonify({'success': True}), 200
    except Exception as e:
        conn.rollback()
        app.logger.error(f"Database operation failed: {str(e)}")
        return jsonify({'error': str(e)}), 500
    finally:
        cur.close()

    return jsonify({'message': 'Product uploaded successfully'}), 201

@app.route('/deleteProduct', methods=['DELETE'])
def delete_product():
    try:
        product_id = request.args.get('product_id')
        print(product_id)

        if not product_id:
            return jsonify({'error': 'No product_name provided'}), 400

        with conn.cursor() as cursor:
            # 查询图片路径
            if product_id.startswith('gem_'):
                # 查询 shop_copy 表中的图片路径
                sql = """
                SELECT product_imageSrc, product_imageSrc1, product_imageSrc2
                FROM shop_copy
                WHERE product_id = %s
                """
            else:
                # 查询 shop 表中的图片路径
                sql = """
                SELECT product_imageSrc, product_imageSrc1, product_imageSrc2
                FROM shop
                WHERE product_id = %s
                """
            cursor.execute(sql, (product_id,))
            result = cursor.fetchone()
            if result:
                # 将图片路径添加到一个列表中
                image_urls = [img_url for img_url in result if img_url]

                # 删除文件
                for img_url in image_urls:
                    if img_url:
                        # 提取路径部分
                        path = urlparse(img_url).path   #将url解析
                        print(path)
                        filename = os.path.basename(path)
                        file_path = os.path.join(app.config['UPLOAD_FOLDER_PRODUCT1'], filename)
                        if os.path.exists(file_path):
                            os.remove(file_path)

            if product_id.startswith('gem_'):
                # 删除 shop_copy 表中的记录
                delete_shop_copy_query = "DELETE FROM shop_copy WHERE product_id = %s"
                cursor.execute(delete_shop_copy_query, (product_id,))
                # 删除 seller 表中的记录
                delete_seller_query = "DELETE FROM seller WHERE product_id = %s"
                cursor.execute(delete_seller_query, (product_id,))
            else:
                # 删除 shop 表中的记录
                delete_shop_query = "DELETE FROM shop WHERE product_id = %s"
                cursor.execute(delete_shop_query, (product_id,))
                # 删除 seller 表中的记录
                delete_seller_query = "DELETE FROM seller_copy WHERE product_id = %s"
                cursor.execute(delete_seller_query, (product_id,))
            conn.commit()

        return jsonify({'message': 'Product deleted successfully'}), 200
    except Exception as e:
        conn.rollback()
        return jsonify({'error': str(e)}), 500

@app.route('/deletecartProduct', methods=['DELETE'])
def delete_cart_product():
    try:
        product_id = request.args.get('product_id')
        print(product_id)

        if not product_id:
            return jsonify({'error': 'No product_name provided'}), 400

        with conn.cursor() as cursor:

            if product_id.startswith('gem_'):
                # 删除 user_cart_copy 表中的记录
                delete_shop_copy_query = "DELETE FROM user_cart_copy WHERE product_id = %s"
                cursor.execute(delete_shop_copy_query, (product_id,))
            else:
                # 删除 user_cart 表中的记录
                delete_shop_query = "DELETE FROM user_cart WHERE product_id = %s"
                cursor.execute(delete_shop_query, (product_id,))
            conn.commit()

        return jsonify({'message': 'Product deleted successfully'}), 200
    except Exception as e:
        conn.rollback()
        return jsonify({'error': str(e)}), 500

@app.route('/upload_test', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'})

    file = request.files['file']

    if file.filename == '':
        return jsonify({'error': 'No selected file'})

    # 处理上传的文件，比如保存到服务器或者进行其他操作
    # 这里只是简单的将文件名返回给前端
    return jsonify({'filename': file.filename})


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

@app.route('/uploadimg/create', methods=['GET'])
def upload_create_Gem():
    images_data = encode_images(UPLOAD_FOLDER_CREATE)
    return jsonify(images_data), 200

@app.route('/predict', methods=['POST'])
def predict():
    # 从请求中获取图像文件
    img_file = request.files['image']
    user_id = request.form.get('user_id')
    print(user_id)

    # 加载 YOLO 模型
    model = YOLO('./best.pt')

    # 使用 PIL（Python Imaging Library）打开图像文件
    image = Image.open(img_file)

    # 确保目标文件夹存在，如果不存在则创建
    save_folder = 'IMG/Rec_gem_img'
    if not os.path.exists(save_folder):
        os.makedirs(save_folder)

    # 保存图像文件
    img_path = os.path.join(save_folder, img_file.filename)
    image.save(img_path)

    # 获取完整的服务器地址
    server_url = request.host_url

    # 替换反斜杠为正斜杠
    img_path = img_path.replace('\\', '/')
    output_image_urls = [server_url + img_path ]
    print(output_image_urls)
    # 如果图像不是 RGB 格式，则转换为 RGB 格式
    image = image.convert('RGB')

    # 对图像进行目标检测
    results = model(image)

    # 宝石类名和对应的中文名称映射字典
    gemstone_dict = {
        'Garnet Red': '石榴石',
        'Alexandrite': '变石(紫翠玉)',
        'Almandine': '铁铝榴石',
        'Benitoite': '蓝锥矿晶体',
        'Beryl Golden': '金绿柱石',
        'Carnelian': '红玛瑙',
        'Cats Eye': '猫眼石',
        'Danburite': '赛黄晶',
        'Diamond': '钻石',
        'Emerald': '翡翠',
        'Fluorite': '萤石',
        'Garnet Red': '红石榴石',
        'Hessonite': '钙铝榴石',
        'Iolite': '堇青石',
        'Jade': '玉',
        'Kunzite': '紫锂辉石',
        'Labradorite': '拉长石',
        'Malachite': '孔雀石',
        'Onyx Black': '缟玛瑙黑',
        'Pearl': '珍珠',
        'Quartz Beer': '蔷薇石英',
        'Rhodochrosite': '红纹石（菱锰矿）',
        'Sapphire Blue': '蓝宝石',
        'Tanzanite': '坦桑石',
        'Variscite': '磷铝石',
        'Zircon': '锆石'
    }

    # 获取预测的宝石类名
    class_name = results[0].names[results[0].probs.top1]
    # 获取对应的中文名称
    gem_name_cn = gemstone_dict.get(class_name, '未知')

    cur = conn.cursor()
    sql = "SELECT gem_content FROM gems WHERE gem_name = %s"
    cur.execute(sql, (gem_name_cn,))
    result = cur.fetchone()
    gem_content = result[0] if result else "暂无介绍"
    # 返回对应的中文名称，如果不存在则返回 '未知'

    # 获取当前时间
    rec_time = time.strftime('%Y-%m-%d %H:%M:%S')


    # 数据写入到数据库的 rec_gem 表中
    cur = conn.cursor()
    sql = "INSERT INTO rec_gem (user_id, gem_content, gem_img_url, gem_name, rec_time) VALUES (%s,%s, %s, %s, %s)"
    cur.execute(sql, (user_id, gem_content, output_image_urls, gem_name_cn, rec_time))
    conn.commit()
    cur.close()

    return jsonify({'gem_name': gem_name_cn, 'gem_content': gem_content})

@app.route('/delete_rec_record', methods=['POST'])
def delete_rec_record():
    data = request.get_json()
    user_id = data.get('user_id')
    create_img_time = data.get('create_img_time')
    img_url = data.get('img_url')  # 获取文件路径
    print(user_id, create_img_time, img_url)

    if not user_id or not create_img_time:
        return jsonify({'error': 'Missing user_id or create_img_time parameter'}), 400

    path = urlparse(img_url).path   #将url解析
    print(path)

    try:
        cur = conn.cursor()
        # 删除记录
        cur.execute("DELETE FROM rec_gem WHERE user_id = %s AND rec_time = %s", (user_id, create_img_time))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({'error': 'Record not found'}), 404

        # 删除文件
        if os.path.exists(path):
            os.remove(path)

        return jsonify({'success': True}), 200
    except Exception as e:
        conn.rollback()
        app.logger.error(f"Database operation failed: {str(e)}")
        return jsonify({'error': str(e)}), 500
    finally:
        cur.close()

@app.route('/get_history', methods=['GET'])
def get_datas():
    # 从请求中获取用户ID
    user_id = request.args.get('user_id')

    # 从数据库加载输出图片的文件名
    cur = conn.cursor()

    # 从数据库加载数据
    cur.execute("SELECT * FROM rec_gem WHERE user_id = %s", (user_id,))
    data_prompt = cur.fetchall()

    output_prompt = [row for row in data_prompt]

    # 返回包含输出图片 URL 和创建时间的 JSON 响应
    response_data = {'all_data': output_prompt}
    return jsonify(response_data)

@app.route('/generate', methods=['POST'])
def generate():


    # # Extract parameters from request
    user_id = int(request.form['user_id'])
    steps = int(request.form['steps'])
    prompt = request.form['prompt']
    negative_prompt = request.form['negative_prompt']
    width = int(request.form['width'])
    height = int(request.form['height'])


    # Other parameters
    sampler_name = "DPM++ 2M"
    seed = 0
    batch_size = 1
    restore_faces = False

    payload = {
        # "prompt": "pandas eating bamboo, ..., (photorealistic:1.4),",
        "prompt": prompt,
        "negative_prompt": negative_prompt,
        "seed": seed,
        "steps": steps,
        "batch_size": batch_size,
        "width": width,
        "height": height,
        "restore_faces": restore_faces,
        "sampler_name": sampler_name,
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

    #保存到数据库
    cur = conn.cursor()
    # 执行插入操作
    insert_query = ("INSERT INTO create_img (user_id, create_img_time, img_url, prompt, negative_prompt, "
                    "steps, height, width) VALUES (%s,%s, %s, %s, %s, %s, %s, %s)")
    cur.execute(insert_query, (user_id, time.strftime('%Y-%m-%d %H:%M:%S'),
                               output_filename, prompt, negative_prompt, steps, height, width))
    conn.commit()

    # 返回包含图像 URL 的 JSON 响应
    return jsonify({'output_image_url': output_image_url})

@app.route('/images/<filename>')
def get_text_image(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)

@app.route('/delete_record', methods=['POST'])
def delete_record():
    data = request.get_json()
    user_id = data.get('user_id')
    create_img_time = data.get('create_img_time')
    img_url = data.get('img_url')  # 获取文件路径
    print(user_id, create_img_time, img_url)

    if not user_id or not create_img_time:
        return jsonify({'error': 'Missing user_id or create_img_time parameter'}), 400

    try:
        cur = conn.cursor()
        # 删除记录
        cur.execute("DELETE FROM create_img WHERE user_id = %s AND create_img_time = %s", (user_id, create_img_time))
        conn.commit()

        if cur.rowcount == 0:
            return jsonify({'error': 'Record not found'}), 404

        # 删除文件
        if os.path.exists(img_url):
            os.remove(img_url)

        return jsonify({'success': True}), 200
    except Exception as e:
        conn.rollback()
        app.logger.error(f"Database operation failed: {str(e)}")
        return jsonify({'error': str(e)}), 500
    finally:
        cur.close()

@app.route('/upload_image', methods=['POST'])
def upload_image():
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400

    file = request.files['image']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    # 读取图片文件
    img = Image.open(file.stream)

    print(request.form)
    # 将图片格式转化
    img_byte_arr = io.BytesIO()
    img.save(img_byte_arr, format='PNG')
    img_byte_arr = img_byte_arr.getvalue()

    # 编码成64位
    encoded_image = base64.b64encode(img_byte_arr).decode('utf-8')
    print(encoded_image)

    # 打包数据
    user_id = int(request.form['user_id'])
    steps = int(request.form['steps'])
    prompt = request.form['prompt']
    negative_prompt = request.form['negative_prompt']
    width = int(request.form['width'])
    height = int(request.form['height'])


    sampler_name = "DPM++ 2M"
    batch_size = 1
    n_iter = 1
    seed = 0
    cfg_scale = 7
    CLIP_stop_at_last_layers = 2
    restore_faces = False

    #  封装 payload
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
    #  发送SDAPI请求
    response = requests.post(url=f'http://127.0.0.1:7860/sdapi/v1/img2img', json=payload)
    r = response.json()
    output_image = Image.open(io.BytesIO(base64.b64decode(r['images'][0])))

    #  创建唯一的文件名
    timestamp = int(time.time())
    output_filename = f'IMG/Save_gem/img_to_img/{timestamp}.png'

    #  保存输出图片
    output_image.save(output_filename)

    # # 获取完整的服务器地址
    server_url = request.host_url  # 获取服务器地址，例如：http://127.0.0.1:5000/

    #  构建输出图像的完整 URL
    output_image_url = server_url + output_filename
    print(output_image_url)

    # 保存到数据库
    cur = conn.cursor()
    #  执行插入操作
    insert_query = ("INSERT INTO create_img (user_id, create_img_time, img_url, prompt, negative_prompt, "
                    "steps, height, width) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)")
    cur.execute(insert_query, (user_id, time.strftime('%Y-%m-%d %H:%M:%S'),
                               output_filename, prompt, negative_prompt, steps, height, width))
    conn.commit()

    # 返回包含图像 URL 的 JSON 响应
    return jsonify({'output_image_url': output_image_url})




if __name__ == '__main__':
    app.run(host="127.0.0.1", debug=True, port=9200)





