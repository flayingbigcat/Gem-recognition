from ultralytics import YOLO

# 初始化 YOLO 模型
model = YOLO('./best.pt')

# 假设有一张名为 image.jpg 的图片需要检测目标
image_path = 'IMG/Gem_img/alexandrite_13.jpg'

# 使用 YOLO 模型进行目标检测
results = model(image_path)
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
# 处理检测结果

print(gem_name_cn)
