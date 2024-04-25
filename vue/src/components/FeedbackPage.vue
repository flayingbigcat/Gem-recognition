<template>
  <header-bar></header-bar>
  <div  style="display: flex; justify-content: center; align-items: center; flex-direction: column;">
    <input type="file" @change="handleFileUpload">
    <img :src="originalImageUrl" v-if="originalImageUrl" alt="Uploaded Image">
    <button @click="uploadImage">上传图片</button>
    <p>预测结果:{{prediction}}</p>

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

export default {
  components: {FooterBar, HeaderBar},
  data() {
    return {
      // image:'',
      file: null,
      originalImageUrl:null,
      prediction:""
    };
  },
  mounted() {
    // this.gain();
  },
  methods: {
    handleFileUpload(event) {
      this.file = event.target.files[0];
      this.originalImageUrl =URL.createObjectURL(this.file);
    },
    uploadImage() {
      let formData = new FormData();
      formData.append('image', this.file);

      axios.post('http://127.0.0.1:9200/predict', formData)
          .then(response => {
            console.log(response.data);
            // 更新识别结果
            this.prediction = response.data;
            console.log(this.prediction);
            // Handle response
          })
          .catch(error => {
            console.error('Error uploading image: ', error);
          });
    },
    // gain(){
    //   axios.get('http://localhost:8081/file/images').then((res)=>{
    //     console.log(res)
    //     this.image = res.data.data[0];
    //     // this.$message.success('图片获取成功');
    //     console.log('图片获取成功');
    //   }).catch(()=>{
    //     // this.$message.error('图片获取失败');
    //     console.log('图片获取失败');
    //   })
    // },
  }
};
</script>

<!--<template>-->
<!--  <el-upload action="#" list-type="picture-card" :auto-upload="false">-->
<!--    <el-icon><Plus /></el-icon>-->
<!--    <el-icon><Male /></el-icon>-->
<!--  </el-upload>-->

<!--  <el-icon><Male /></el-icon>-->
<!--  <el-dialog v-model="dialogVisible">-->
<!--    <img w-full :src="url" alt="Preview Image" />-->
<!--  </el-dialog>-->
<!--</template>-->

<!--<script  setup >-->
<!--import {ref} from "vue"-->

<!--const url = ref('D:\\迅雷下载\\course14\\course14\\image\\app.jpg')-->
<!--</script>-->





<!--<template>-->
<!--  <div class="avatar-uploader">-->
<!--    <input-->
<!--        type="file"-->
<!--        accept="image/jpeg"-->
<!--        style="display: none"-->
<!--        ref="fileInput"-->
<!--        @change="handleFileChange"-->
<!--    />-->
<!--    <img v-if="imageUrl" :src="imageUrl" class="avatar" />-->
<!--    <el-icon v-else class="avatar-uploader-icon" @click="handleClick"><Plus /></el-icon>-->
<!--  </div>-->
<!--</template>-->

<!--<script>-->
<!--export default {-->
<!--  data() {-->
<!--    return {-->
<!--      imageUrl: ''-->
<!--    };-->
<!--  },-->
<!--  methods: {-->
<!--    handleFileChange(event) {-->
<!--      const file = event.target.files && event.target.files[0];-->
<!--      if (file) {-->
<!--        if (file.type !== 'image/jpeg') {-->
<!--          this.$message.error('Avatar picture must be JPG format!');-->
<!--          return;-->
<!--        } else if (file.size / 1024 / 1024 > 2) {-->
<!--          this.$message.error('Avatar picture size can not exceed 2MB!');-->
<!--          return;-->
<!--        }-->
<!--        this.imageUrl = URL.createObjectURL(file);-->
<!--      }-->
<!--    },-->
<!--    handleClick() {-->
<!--      const input = document.createElement('input');-->
<!--      input.type = 'file';-->
<!--      input.accept = 'image/jpeg';-->
<!--      input.style.display = 'none';-->
<!--      input.addEventListener('change', this.handleFileChange);-->
<!--      document.body.appendChild(input);-->
<!--      input.click();-->
<!--      document.body.removeChild(input);-->
<!--    }-->
<!--  }-->
<!--};-->
<!--</script>-->

<!--<style scoped>-->
<!--.avatar-uploader .avatar {-->
<!--  width: 178px;-->
<!--  height: 178px;-->
<!--  display: block;-->
<!--}-->

<!--.avatar-uploader .el-icon.avatar-uploader-icon {-->
<!--  font-size: 28px;-->
<!--  color: #8c939d;-->
<!--  width: 178px;-->
<!--  height: 178px;-->
<!--  text-align: center;-->
<!--  cursor: pointer;-->
<!--  border: 1px dashed var(&#45;&#45;el-border-color);-->
<!--  border-radius: 6px;-->
<!--  transition: var(&#45;&#45;el-transition-duration-fast);-->
<!--}-->

<!--.avatar-uploader .el-icon.avatar-uploader-icon:hover {-->
<!--  border-color: var(&#45;&#45;el-color-primary);-->
<!--}-->
<!--</style>-->









