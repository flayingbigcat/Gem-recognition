import json
import requests
import io
import base64
from PIL import Image
import cv2

url = "http://0.0.0.0:7860"

prompt = "jade brooch"
negative_prompt = ""

# 此处为读取一张图片作为输入图像
img = cv2.imread('jade_0.jpg')

# 编码图像
retval, bytes = cv2.imencode('.png', img)
encoded_image = base64.b64encode(bytes).decode('utf-8')

payload = {

    #     # 模型设置
    #     "override_settings":{
    #           "sd_model_checkpoint": "v1-5-pruned.ckpt",
    #           "sd_vae": "animevae.pt",
    #           "CLIP_stop_at_last_layers": 2,
    #     },

    # 基本参数
    "prompt": prompt,
    "negative_prompt": negative_prompt,
    "steps": 30,
    # "sampler_name": "Euler a",
    "sampler_name": "DPM++ 2M",
    "width": 512,
    "height": 512,
    "batch_size": 1,
    "n_iter": 1,
    "seed": 1,
    "cfg_scale": 7,
    "CLIP_stop_at_last_layers": 2,

    "init_images": [encoded_image],

    # 面部修复 face fix
    "restore_faces": False,

    #高清修复 highres fix
    # "enable_hr": True,
    # "denoising_strength": 0.4,
    # "hr_scale": 2,
    # "hr_upscaler": "Latent",

}



response = requests.post(url=f'{url}/sdapi/v1/img2img', json=payload)
r = response.json()
image = Image.open(io.BytesIO(base64.b64decode(r['images'][0])))

image.show()
image.save('output1.png')