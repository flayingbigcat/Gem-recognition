<template xmlns:v-bind="http://www.w3.org/1999/xhtml">
  <header-bar></header-bar>
<!--   <div class="centered-container">-->
<!--    <el-select v-model="value" placeholder="请选择要转换的图片风格" class="custom-select"  >-->
<!--      <el-option-->
<!--        v-for="item in options"-->
<!--        :key="item.value"-->
<!--        :label="item.label"-->
<!--        :value="item.value">-->
<!--      </el-option>-->
<!--    </el-select>-->
<!--  </div>-->




  <div  style="display: flex; justify-content: center; align-items: center; flex-direction: column;">
    <input type="file" @change="handleFileUpload">

<div id="app" class="centered-container">
    <select v-model="selectedOption" @change="handleSelectChange">
      <option v-for="option in options" :key="option.value" :value="option.value">
        {{ option.label }}
      </option>
    </select>
<!--    <p>当前选中的是: {{ selectedOption }}</p>-->
  </div>

<!--    <input type="file" @change="handleWeightFileUpload">-->
    <img :src="originalImageUrl" v-if="originalImageUrl" alt="Uploaded Image">
    <button @click="PassInThePicture">上传图片</button>
    <!-- Loading 组件，根据 uploading 变量决定是否显示 -->
    <el-loading v-if="uploading" text="识别中..." :background="'rgba(0, 0, 0, 0.7)'"></el-loading>
    <p>结果:{{prediction}}</p>
    <span>{{  }}</span>
<!--<img src='../output_img/alexandrite_18.jpg' alt="Prediction Image">-->
<!--<img v-bind:src="'../output_img/' + predictionImagename" alt="裂开了">-->
<!--<img v-bind:src="` vue/public/static/output_img/${predictionImagename} `" alt="裂开了">-->
<!--<img v-bind:src="` vue/public/static/output_img/${predictionImagename} `" alt="裂开了">-->

<!--    接受图片并解码-->
    <img :src="'data:image;base64,' + image" alt="Convert the results">



<!--<p>Message: {{ `vue/public/static/output_img/${predictionImagename}` }}</p>-->
<!--    <img :src=" '../../transfers/output_img' + prediction" v-if=" '../../../transfers/output_img' + prediction" alt="prediction Image">-->
<!--    <img :src='D:\\github\\Gem-recognition\\transfers\\output_img\\alexandrite_3.jpg' v-if="prediction" alt="prediction Image">-->

<!--    <div >-->
<!--      <div >-->
<!--        <img :src="'data:image;base64,'+image">-->
<!--      </div>-->
<!--    </div>-->
  </div>
  <footer-bar></footer-bar>
</template>

<script >
import axios from "axios";
import HeaderBar from "@/components/HeaderBar.vue";
import FooterBar from "@/components/FooterPage.vue";
import {ElLoading} from "element-plus";

export default {
  components: {FooterBar, HeaderBar},
  data() {
    return {
      file: null,
      weight_file: null,
      originalImageUrl:null,
      selectedOption: '',
      predictionImagename: null,
      prediction:"",
      uploading: false,
      jsonString:'',
      image: '',
      value: '',
      options: [
        {value: 'Option1', label: '选项一:毕加索',filePath:'/transfers/checkpoints/la_muse.ckpt',fileId:1},
        {value: 'Option2', label: '选项二:七彩斑斓'},
        {value: 'Option3', label: '选项三:呐喊'},
        {value: 'Option4', label: '选项四:暴风雨'},
        {value: 'Option5', label: '选项五:皮卡比亚'},
        {value: 'Option6', label: '选六:浮世绘'}
      ],
      formData: null,
    };
  },
  mounted() {
    // this.gain();
  },
  methods: {
    handleSelectChange() {
      // this.weight_file = this.selectedOption;
      // this.originalImageUrl =URL.createObjectURL(this.selectedOption);
      console.log('选中的值已更改:', this.selectedOption);
      // this.jsonString = JSON.stringify(this.selectedOption)
      // alert(this.weight_file);
    },
    handleFileUpload(event) {
      this.file = event.target.files[0];
      this.originalImageUrl = URL.createObjectURL(this.file);
    },
    // handleWeightFileUpload(event) {
    //   this.weight_file = event.target.files[0];
    //   // this.originalImageUrl =URL.createObjectURL(this.file);
    //   console.log(this.weight_file)
    // },
    PassInThePicture() {
      this.uploading = true; // 开始上传时显示加载动画
      this.openFullScreen2(); // 调用显示全屏加载动画的方法
      let formData = new FormData();

      formData.append('image', this.file);
      // console.log(this.selectedOption)
      // formData.append('weight_file', this.weight_file);

      formData.append('selectedOption', this.selectedOption);
      console.log(formData.get('selectedOption'));
      axios.post('http://127.0.0.1:9300/predict2', formData,)
          .then(response => {
            console.log(response);
            this.image = response.data.image;
          })
          .catch(error => {
            console.error('Error uploading image: ', error);
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
    },
    closeFullScreen2() {
      ElLoading.service().close();
    }
  }
};
</script>



<style scoped>
.centered-container {
  display: flex;
  justify-content: center; /* 水平居中 */
}
.custom-select {
  /* 假设你的普通按钮的样式是 40px 高，100px 宽 */

  width: 200px;
  height: 40px;
  /* 可能需要覆盖 Element UI 的默认样式 */
  .el-select__caret {

    /* 调整下拉箭头的大小和位置 */
    font-size: 16px;
    margin-top: -8px; /* 根据需要调整 */
  }
  /* 其他的样式调整，如边框、圆角等 */
  .el-select .el-input__inner {
    height: 100%; /* 确保输入框填满整个 select 组件的高度 */
    line-height: 40px; /* 调整文本垂直居中 */
    padding: 0 10px; /* 调整文本内边距 */
  }
}
</style>



