from ultralytics import YOLO
from datetime import datetime

# 初始化 YOLO 模型
model = YOLO('weights/best_fruit.pt')

# 假设有一张名为 image.jpg 的图片需要检测目标
image_path = 'fruit_img/images/2023100262070541_jpg.rf.23a85a93d88be1431cbec099f7cc0902.jpg'

# 使用 YOLO 模型进行目标检测
results = model(image_path)
# 打印检测结果
print(results)

# 绘制检测结果
results_plotted = results[0].plot()

# 生成保存文件名，包含日期时间信息
current_time = datetime.now().strftime("%Y%m%d_%H%M%S")
save_path = f'runs/result/detected_image_{current_time}.jpg'

# 保存检测后的图片
results[0].save(save_path)
