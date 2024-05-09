<template>
  <header-bar></header-bar>
  <div class="outer-container">
    <h2 class="text-center">AI创作</h2>
    <div class="img_container">
      <div class="container">
        <div>
<!--          <form class="w-75" >-->
            <div>
              <input type="file" @change="handleGeneratedFileUpload">
              <div >
                <img v-if="uploadedImage" :src="uploadedImage" class="uploaded-image"  >
              </div>
            </div>

            <div class="mb-3 ">
              <label class="form-label">提示词</label>
              <textarea class="form-control" id="prompt" v-model="prompt" rows="2" placeholder="请输入提示词"></textarea>
            </div>
            <div class="mb-3">
              <label class="form-label">反向提示词</label>
              <textarea id="negativePrompt" v-model="negative_prompt" class="form-control" placeholder="请输入反向提示词"></textarea>
            </div>
            <div class="slider-demo-block">
              <label class="form-label">采样迭代次数</label>
              <el-slider v-model="steps" :min="1" :max="50" show-input />
            </div>
            <div class="slider-demo-block">
              <label class="form-label">图像高度</label>
              <el-slider v-model="height" :min="1" :max="1080" show-input />
            </div>
            <div class="slider-demo-block">
              <label class="form-label">图像宽度</label>
              <el-slider v-model="width" :min="1" :max="1080" show-input />
            </div>
<!--            <button @click="ImagegenerateImage" class="btn btn-primary">生成图像</button>-->
            <el-button @click="ImagegenerateImage" :disabled="uploading" type="primary">生成图像</el-button>
            <!-- Loading 组件，根据 uploading 变量决定是否显示 -->
            <el-loading v-if="uploading" text="努力生成中..." :background="'rgba(0, 0, 0, 0.7)'"></el-loading>
<!--          </form>-->

        </div>
      </div>
      <div class="preview-container">
        <div class="image-preview">
          <!-- 预览框 -->
          <img v-if="outputImageBase64" :src="'data:image;base64,' + outputImageBase64" alt="Generated Image">
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-1" v-for="(image, index) in Gem_pictures" :key="index">
        <div class="product-item">
          <div class="card text-center">
            <!-- 使用后端返回的图片数据 -->
            <img :src="'data:image;base64,' + image" class="card-img-top" alt="...">
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import HeaderBar from "@/components/HeaderBar.vue";
import { ElLoading } from 'element-plus';
import axios from "axios";
export default {
  components: {  HeaderBar },
  data() {
    return {
      selectedFile: null,
      outputImageBase64: '', // Initialize to an empty string
      generatedImage: '',
      file: null,
      originalImageUrl: null,
      uploadedImage: null,
      prediction: "",
      uploading: false,
      steps: 20,
      height: 512,
      width: 512,
      prompt: '',
      negative_prompt: '',
      Gem_pictures:[],
    };
  },
  mounted() {
    this.gain_gam();
  },
  methods: {
    handleGeneratedFileUpload(event) {
      this.selectedFile = event.target.files[0];
      this.uploadedImage = URL.createObjectURL(this.selectedFile);
    },
    openFullScreen2() {
      ElLoading.service({
        lock: true,
        text: '努力创作中...',
        background: 'rgba(0, 0, 0, 0.7)',
      });
      // 注意：这里不需要设置关闭时间，会在 uploadImage 方法中手动关闭
      // setTimeout(() => {
      //   loadingInstance.close();
      // }, 2000);
    },
    closeFullScreen2() {
      ElLoading.service().close();
    },
    async generateImages() {
      this.uploading = true; // 开始上传时显示加载动画
      this.openFullScreen2(); // 调用显示全屏加载动画的方法
      let formData = new FormData();
      formData.append('image', this.selectedFile);
      formData.append('steps', this.steps);
      formData.append('height', this.height);
      formData.append('width', this.width);
      formData.append('negative_prompt', this.negative_prompt);
      formData.append('prompt', this.prompt);

      // 发送POST请求以获取生成的图像
      // axios.post('http://127.0.0.1:9200/generate')
      //     .then(response => {
      //       // 设置生成的图像的Base64编码数据
      //       this.generatedImage = response.data.generated_image_base64;
      //     })
      //     .catch(error => {
      //       console.error('Error:', error);
      //     });
      try {
        const response = await axios.post('http://127.0.0.1:9200/generate', formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        }).finally(() => {
          this.closeFullScreen2(); // 接收到数据后关闭加载动画
          this.uploading = false;
        });

        if (response.data && response.data.output_image_base64) {
          this.outputImageBase64 = response.data.output_image_base64;
          this.gain_gam();
        } else {
          alert('Failed to generate image.');
        }
      } catch (error) {
        console.error('Error generating image:', error);
        alert('Error generating image. Please try again later.');
      }
    },
    async ImagegenerateImage() {
      this.uploading = true; // 开始上传时显示加载动画
      this.openFullScreen2(); // 调用显示全屏加载动画的方法
      if (!this.selectedFile) {
        // alert('Please select an image first.');
        await this.generateImages();
        return;
      }

      let formData = new FormData();
      formData.append('image', this.selectedFile);
      formData.append('steps', this.steps);
      formData.append('height', this.height);
      formData.append('width', this.width);
      formData.append('negative_prompt', this.negative_prompt);
      formData.append('prompt', this.prompt);


      try {
        const response = await axios.post('http://127.0.0.1:9200/upload_image', formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        }).finally(() => {
          this.closeFullScreen2(); // 接收到数据后关闭加载动画
          this.uploading = false;
        });

        if (response.data && response.data.output_image_base64) {
          this.outputImageBase64 = response.data.output_image_base64;
          this.gain_gam();
        } else {
          alert('Failed to generate image.');
        }
      } catch (error) {
        console.error('Error generating image:', error);
        alert('Error generating image. Please try again later.');
      }
    },
    //获取生成的图片
    gain_gam(){
      axios.get('http://127.0.0.1:9200/uploadimg/create').then((res)=>{
        console.log(res)
        this.Gem_pictures = res.data;
        // this.$message.success('图片获取成功');
        // localStorage.setItem('Gem_pictures', JSON.stringify(res.data.data));
        console.log('图片获取成功');
      }).catch(()=>{
        // this.$message.error('图片获取失败');
        console.log('图片获取失败');
      })
    },
  }
};

</script>

<style>
.outer-container {
  border: 2px solid #ddd;
  padding: 20px;
}
.img_container {
  background-color: #f9f9f9;
  border: 1px solid #ddd;
  padding: 0px;
}

.img_container .block {
  background-color: #f9f9f9;
  border: 1px solid #ddd;
  padding: 30px;
  margin: 100px 0;
}
.img_container .block a {
  color: #595b5d;
}

.img_container .block h2 {
  font-weight: 400;
  font-size: 25px;
  text-transform: uppercase;
  margin-top: 40px;
}
.img_container .block form {
  margin-top: 40px;
}

.img_container .block form .btn-main {
  padding: 14px 19px;
}

.img_container .block form p {
  margin-bottom: 20px;
}
.slider-demo-block {
  max-width: 600px;
}
.img_container {
  display: flex;
}

.container {
  flex: 1;
}

.preview-container {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
}

.image-preview {
  width: 512px;
  height: 512px;
  border: 1px solid #595b5d;
}
.uploaded-image {
  width: 250px;
  height: 250px;
}
</style>
