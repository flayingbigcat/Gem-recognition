<template>
    <div>
        <header-bar></header-bar>
    </div>
    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="content">
                        <h1 class="page-name">欢迎</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                              <li class="breadcrumb-item" style="font-size: 20px"><router-link style="text-decoration: none" to="/">首页</router-link></li>
                              <li class="breadcrumb-item" style="font-size: 20px"><router-link style="text-decoration: none" to="/ShopPage">宝石商城</router-link></li>
                              <li class="breadcrumb-item" style="font-size: 20px"><router-link style="text-decoration: none" to="/UploadProduct">发布商品</router-link></li>
                              <li class="breadcrumb-item active" aria-current="page" style="font-size: 20px">我的发布</li>
                              <li class="breadcrumb-item" style="font-size: 20px"><router-link style="text-decoration: none" to="/CartPage">我的收藏</router-link></li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="dashboard-Cart">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col"></th>
                    <th scope="col">商品名称</th>
                    <th scope="col">发布时间</th>
                    <th scope="col">商品价格</th>
                </tr>
                </thead>
                <tbody class="table-group-divider">
                <tr v-for="(item, index) in tableData" :key="index">
                    <th scope="row"><el-image
                        style="width: 100px; height: 100px"
                        :src="item[4]"
                        ></el-image></th>
                    <td>{{ item[1] }}</td>
                  <td>{{ item[3] }}</td>
                  <td>{{ item[2] }}</td>
                  <td><button class="btn btn-dark" @click="deleteRow(index, item[0])">删除</button></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <footer-bar></footer-bar>
</template>
<script>
import HeaderBar from "@/components/HeaderBar.vue";
import {defineComponent} from "vue";
import FooterBar from "@/components/FooterPage.vue";
import axios from "axios";

export default defineComponent({
    components: {FooterBar, HeaderBar},
    data() {
        return {
            tableData: [],
          fits: ['fill', 'contain', 'cover', 'none', 'scale-down'],
          url:'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
        };
    },
  mounted() {
    this.getProducts(); // 在组件挂载完成后立即获取产品信息
  },
  methods: {
    // 获取产品信息的方法
    async getProducts() {
      try {
        const user_id = localStorage.getItem('user_id'); // 从localStorage获取用户ID，您也可以从其他地方获取
        const response = await axios.get(`http://127.0.0.1:9200/getProducts?user_id=${user_id}`);
        this.tableData = response.data; // 将获取到的产品信息填充到tableData数组中
        console.log(response)
        console.log(this.tableData)
      } catch (error) {
        console.error('Error getting products:', error);
        alert('目前还未发布商品.');
      }
    },
    // 删除行的方法
    async deleteRow(index, product_id) {
      try {
        const response = await axios.delete(`http://127.0.0.1:9200/deleteProduct`, {
          params: { product_id: product_id }
        });
        if (response.status === 200) {
          this.tableData.splice(index, 1); // 从前端表格中移除这一行
          alert('Product deleted successfully');
        }
      } catch (error) {
        console.error('Error deleting product:', error);
        alert('Failed to delete product.');
      }
    }
  }
})

</script>
<style>
@import "../css/_common.css";
</style>