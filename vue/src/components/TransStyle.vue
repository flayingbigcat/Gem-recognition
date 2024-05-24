<template>
  <header-bar></header-bar>
  <div id="app" class="centered-container">
    <!-- 左侧按钮 -->
    <div class="button-container">
      <div class="image-placeholder" v-if="!originalImageUrl">
        <p>上传的图片</p>
      </div>
      <div v-else class="image-wrapper">
        <img :src="originalImageUrl" alt="Uploaded Image">
      </div>
      <div>
        <input type="file" @change="handleFileUpload" style="display: none;">
        <button type="button" class="btn btn-primary" onclick="document.querySelector('input[type=file]').click()">
          选择文件
        </button>
      </div>
    </div>
    <!-- 下方选择转换风格 -->
    <div class="style-selection">
      <select v-model="selectedOption" @change="handleSelectChange">
        <option disabled value="">选择要转换的风格</option>
        <option v-for="option in options" :key="option.value" :value="option.value">
          {{ option.label }}
        </option>
      </select>
    </div>
    <br><br>
    <!-- 右侧按钮 -->
    <div class="button-container">
      <div class="image-placeholder" v-if="!image">
        <p>转换的结果</p>
      </div>
      <div v-else class="image-wrapper">
        <el-loading v-if="uploading" text="识别中..." :background="'rgba(0, 0, 0, 0.7)'"></el-loading>
        <img :src="'data:image;base64,' + image" alt="Convert the results">
      </div>
      <div>
        <button type="button" class="btn btn-primary" @click="PassInThePicture">
          上传图片
        </button>
      </div>
    </div>
    <!--  <img :src="originalImageUrl" v-if="originalImageUrl" alt="Uploaded Image">-->
    <!--  &lt;!&ndash; Loading 组件，根据 uploading 变量决定是否显示 &ndash;&gt;-->
    <!--  <el-loading v-if="uploading" text="识别中..." :background="'rgba(0, 0, 0, 0.7)'"></el-loading>-->
    <!--  <p>转换结果: {{ prediction }}</p>-->
    <!--  <img :src="'data:image;base64,' + image" alt="Convert the results">-->
  </div>
</template>
<script>
// export default {
//   name: "TransStyle"
// }
import axios from "axios";
import HeaderBar from "@/components/HeaderBar.vue";
import {ElLoading} from "element-plus";
export default {
  components: { HeaderBar},
  name: "TransStyle",
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
        {value: 'Option1', label: '一:毕加索'},
        {value: 'Option2', label: '二:七彩斑斓'},
        {value: 'Option3', label: '三:呐喊'},
        {value: 'Option4', label: '四:暴风雨'},
        {value: 'Option5', label: '五:皮卡比亚'},
        {value: 'Option6', label: '六:浮世绘'}
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

<style>
.centered-container {
  display: flex;
  flex-direction: column;
  align-items: center;
}
.image-container {
  text-align: center;
}
.image-placeholder,
.image-wrapper {
  border: 1px solid black;
  width: 200px;
  height: 200px;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 20px;
}
.image-placeholder p,
.image-wrapper img {
  max-width: 100%;
  max-height: 100%;
}
.button-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 400px;
  margin-bottom: 5px;
}
.button-placeholder {
  border: 1px solid black;
  width: 200px;
  height: 200px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.style-selection {
  text-align: center;
  margin-top: 20px;
}
</style>