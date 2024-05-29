<script>
import HeaderBar from "@/components/HeaderBar.vue";
import axios from "axios";

export default {
  name: "UploadProduct",
  components: {HeaderBar},
  data() {
    return {
      radio1: '',
      // 从localStorage获取数据并初始化data属性
      product_datas: [],
      user_id:localStorage.getItem('user_id'),
      dialogImageUrl: '',
      dialogVisible: false,
      selectedFiles: [], // 用于存储选择的文件数组
      fileList: [] // 用于存储显示的文件列表
    };
  },
  methods:{
    handleRemove(file, fileList) {
      console.log(file, fileList);
      // 从选中的文件数组中移除文件
      this.selectedFiles = this.selectedFiles.filter(f => f !== file.raw);
    },
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url || file.raw;
      this.dialogVisible = true;
    },
    handleFileChange(file, fileList) {
      this.fileList = fileList;
      this.selectedFiles = fileList.map(f => f.raw);
    },
    async saveProduct() {
      try {
        if (this.radio1 === '') {
          alert('请选择上传类型。');
          return;
        }
        if (this.selectedFiles.length !== 3) {
          alert('请上传3张图片。');
          return;
        }
        if (this.product_datas[1] === '') {
          alert('请输入商品名称。');
          return;
        }
        // 使用FormData对象
        let formData = new FormData();
        formData.append('user_id', this.user_id);
        formData.append('product_name', this.product_datas[1]);
        formData.append('product_description', this.product_datas[6]);
        formData.append('product_price', this.product_datas[5]);
        formData.append('seller_email', this.product_datas[2]);
        formData.append('seller_phone', this.product_datas[3]);
        formData.append('shipping_address', this.product_datas[4]);

        // 将文件添加到FormData中
        this.selectedFiles.forEach((file, index) => {
          formData.append(`file${index}`, file);
        });

        // 根据选择设置上传 URL
        const uploadUrl = this.radio1 === '宝石发布'
            ? 'http://127.0.0.1:9200/uploadProduct'
            : 'http://127.0.0.1:9200/uploadAIProduct';

        const response = await axios.post(uploadUrl, formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        });
        console.log(response.data);
        alert('Product uploaded successfully!');
      } catch (error) {
        console.error('Error uploading product:', error);
        alert('Failed to upload product.');
      }
    },
  },
}
</script>

<template>
  <header-bar></header-bar>
  <div class="page-header">
    <div class="container">
      <div class="row">
        <div class="col-md-12 d-flex justify-content-center">
          <div class="content">
            <h1 class="page-name">欢迎</h1>
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><router-link style="text-decoration: none" to="/">首页</router-link></li>
                <li class="breadcrumb-item"><router-link style="text-decoration: none" to="/ShopPage">宝石商城</router-link></li>
                <li class="breadcrumb-item active" aria-current="page">发布商品</li>
                <li class="breadcrumb-item"><router-link style="text-decoration: none" to="/OrderPage">我的发布</router-link></li>
                <li class="breadcrumb-item"><router-link style="text-decoration: none" to="/CartPage">我的收藏</router-link></li>
              </ol>
            </nav>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="container d-flex justify-content-center">
    <div class="dashboard-wrapper">
      <div class="media">
        <div class="pull-left">
          <div>
            <el-radio-group v-model="radio1">
              <el-radio-button label="宝石发布"></el-radio-button>
              <el-radio-button label="宝石创作"></el-radio-button>
            </el-radio-group>
          </div>
          <el-upload
              list-type="picture-card"
              action="http://127.0.0.1:9200/upload_test"
              :on-preview="handlePictureCardPreview"
              :on-remove="handleRemove"
              :on-change="handleFileChange"
              multiple>
            <i class="el-icon-plus">上传图片</i>
          </el-upload>
        </div>
        <div class="media-body">
          <h2 class="media-heading">商品名</h2>
          <input class="form-control media-heading w-50" v-model="product_datas[1]" id="userNameInput" placeholder="">
          <div class="form-floating p-1">
            <p>商品描述</p>
            <textarea class="form-control" v-model="product_datas[6]" id="floatingTextarea2" style="height: 100px"></textarea>
          </div>
        </div>
      </div>
      <form class="row g-3 mt-1">
        <div class="col-md-4">
          <label for="inputEmail4" class="form-label">商品价格</label>
          <input class="form-control" v-model="product_datas[5]" id="userSexInput" placeholder="">
        </div>
        <div class="col-4">
          <label for="inputAddress" class="form-label">商家邮箱</label>
          <input class="form-control" v-model="product_datas[2]" id="userSexInput" placeholder="">
        </div>
        <div class="col-6">
          <label for="inputAddress2" class="form-label">商家电话号码</label>
          <input class="form-control" v-model="product_datas[3]" id="userPhoneInput" placeholder="">
        </div>
        <div class="col-md-12">
          <label for="inputCity" class="form-label">发货地址</label>
          <div class="col-md-6">
            <input class="form-control" v-model="product_datas[4]" id="userAddressInput" placeholder="">
          </div>
        </div>
      </form>
      <div class="d-grid gap-2 col-2 mx-auto mt-3">
        <router-link class="btn btn-outline-secondary me-md-2" to="#" @click="saveProduct">保存</router-link>
      </div>
    </div>
  </div>

</template>

<style scoped>

</style>