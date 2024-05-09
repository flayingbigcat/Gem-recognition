<template>
  <header-bar></header-bar>
  <div style="display: flex; justify-content: center; align-items: center; flex-direction: column;">
    <input type="file" @change="handleFileUpload">
    <div class="justify-content-center">
      <img :src="originalImageUrl" v-if="originalImageUrl" alt="上传的图片" class="w-25">
    </div>

    <el-button @click="uploadImage" :disabled="uploading" type="primary">上传图片</el-button>
    <!-- Loading 组件，根据 uploading 变量决定是否显示 -->
    <el-loading v-if="uploading" text="努力创作中..." :background="'rgba(0, 0, 0, 0.7)'"></el-loading>

    <!-- 显示识别结果 -->
    <p >识别结果: {{ prediction }}</p>
  </div>

  <div>
    <button @click="generateImages">生成图片</button>
    <img :src="'data:image;base64,' + generatedImage">
  </div>
  <div>
    <input type="file" @change="handleGeneratedFileUpload">
    <img v-if="uploadedImage" :src="uploadedImage" >
    <button @click="ImagegenerateImage">Generate Image</button>
    <img v-if="outputImageBase64" :src="'data:image;base64,' + outputImageBase64" alt="Generated Image">
  </div>

  <footer-bar></footer-bar>
</template>

<script>
import { ElLoading } from 'element-plus';
import axios from 'axios';
import HeaderBar from "@/components/HeaderBar.vue";
import FooterBar from "@/components/FooterPage.vue";

export default {
  components: { FooterBar, HeaderBar },
  data() {
    return {
      selectedFile: null,
      outputImageBase64: null,
      generatedImage: '',
      file: null,
      originalImageUrl: null,
      uploadedImage: null,
      prediction: "",
      uploading: false,

    };
  },
  methods: {
    handleGeneratedFileUpload(event) {
      this.selectedFile = event.target.files[0];
      this.uploadedImage = URL.createObjectURL(this.selectedFile);
    },
    handleFileUpload(event) {
      this.file = event.target.files[0];
      this.originalImageUrl = URL.createObjectURL(this.file);
    },
    uploadImage() {
      this.uploading = true; // 开始上传时显示加载动画
      this.openFullScreen2(); // 调用显示全屏加载动画的方法

      let formData = new FormData();
      formData.append("image", this.file);

      axios
          .post("http://127.0.0.1:9200/predict", formData)
          .then(response => {
            console.log(response.data);
            this.prediction = response.data;

          })
          .catch(error => {
            console.error("上传图片时出错: ", error);
          })
          .finally(() => {
            this.closeFullScreen2(); // 接收到数据后关闭加载动画
            this.uploading = false;
          });
    },
    openFullScreen2() {
       ElLoading.service({
        lock: true,
        text: '识别中...',
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
      // 发送POST请求以获取生成的图像
      axios.post('http://127.0.0.1:9200/generate')
          .then(response => {
            // 设置生成的图像的Base64编码数据
            this.generatedImage = response.data.generated_image_base64;
          })
          .catch(error => {
            console.error('Error:', error);
          });
    },
    async ImagegenerateImage() {
      if (!this.selectedFile) {
        alert('Please select an image first.');
        return;
      }

      let formData = new FormData();
      formData.append('image', this.selectedFile);

      try {
        const response = await axios.post('http://127.0.0.1:9200/upload_image', formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        });

        if (response.data && response.data.output_image_base64) {
          this.outputImageBase64 = response.data.output_image_base64;
        } else {
          alert('Failed to generate image.');
        }
      } catch (error) {
        console.error('Error generating image:', error);
        alert('Error generating image. Please try again later.');
      }
    }
  }
};
</script>










