<template>
  <header-bar></header-bar>
  <div style="display: flex; justify-content: center; align-items: center; flex-direction: column;">
    <input type="file" @change="handleFileUpload">
    <div class="justify-content-center">
      <img :src="originalImageUrl" v-if="originalImageUrl" alt="上传的图片" >
    </div>

    <el-button @click="uploadImage" :disabled="uploading" type="primary">上传图片</el-button>
    <!-- Loading 组件，根据 uploading 变量决定是否显示 -->
    <el-loading v-if="uploading" text="识别中..." :background="'rgba(0, 0, 0, 0.7)'"></el-loading>

    <!-- 显示识别结果 -->
    <p >识别结果: {{ prediction }}</p>
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
      file: null,
      originalImageUrl: null,
      prediction: "",
      uploading: false
    };
  },
  methods: {
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
    }
  }
};
</script>










