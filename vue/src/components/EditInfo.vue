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
                                <li class="breadcrumb-item active" aria-current="page">收藏</li>
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
                    <img class="media-object user-img" :src="user_datas[7]" alt="Image">
                </div>
<!--                <div class="dropdown mt-1">-->
<!--                    <button class="btn btn-outline-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Picture</button>-->
<!--                    <ul class="dropdown-menu">-->
<!--                        <li><a class="dropdown-item" href="#">Action</a></li>-->
<!--                        <li><a class="dropdown-item" href="#">Another action</a></li>-->
<!--                        <li><a class="dropdown-item" href="#">Something else here</a></li>-->
<!--                    </ul>-->
<!--                </div>-->
                <div class="media-body">
                    <h2 class="media-heading">用户名</h2>
                    <input class="form-control media-heading" v-model="user_datas[1]" id="userNameInput" placeholder="User Name">
                    <p>个性签名</p>
                    <input class="form-control" v-model="user_datas[4]" id="userEmailInput" placeholder="Description">
                </div>
            </div>
            <form class="row g-3 mt-1">
                <div class="col-md-4">
                    <label for="inputEmail4" class="form-label">性别</label>
                    <input class="form-control" v-model="user_datas[5]" id="userSexInput" placeholder="Sex">
                </div>
                <div class="col-4">
                    <label for="inputAddress" class="form-label">邮箱</label>
                    <p>{{ user_datas[2] }}</p>
                </div>
                <div class="col-6">
                    <label for="inputAddress2" class="form-label">电话号码</label>
                    <input class="form-control" v-model="user_datas[3]" id="userPhoneInput" placeholder="Phone Number">
                </div>
                <div class="col-md-12">
                    <label for="inputCity" class="form-label">地址</label>
                    <div class="col-md-6">
                        <input class="form-control" v-model="user_datas[6]" id="userAddressInput" placeholder="Address">
                    </div>
                </div>
            </form>
            <div class="d-grid gap-2 col-2 mx-auto mt-3">
                <router-link class="btn btn-outline-secondary me-md-2" to="#" @click="delayedUpdateUser">保存</router-link>
            </div>
        </div>
    </div>

</template>


<script>
// import {defineComponent} from 'vue'
import HeaderBar from "@/components/HeaderBar.vue";
import axios from 'axios';


export default {
    name: "EditInfo",
    components: { HeaderBar },
    data() {
        return {
            // 从localStorage获取数据并初始化data属性
          user_datas: [],
            user_id:localStorage.getItem('user_id'),

        };
    },
    methods:{
      delayedUpdateUser() {
        this.updateUser(); // 首先执行更新操作
        setTimeout(() => {
          this.$router.push('/UserPage'); // 延时跳转到 UserPage 页面
        }, 1000); // 延时 1 秒
      },
        async updateUser() {
            const user = {
                user_id: this.user_id, // 确保这是有效的用户标识符
                user_name: this.user_datas[1],
                user_email: this.user_datas[2],
                user_address: this.user_datas[6],
                user_phone: this.user_datas[3],
                user_sex: this.user_datas[5],
                user_description: this.user_datas[4],
                user_imageSrc: this.user_datas[7],
            };
            console.log("USER:",user)
          const apiUrl = "http://127.0.0.1:9200/reviseUser";

          try {
            const response = await axios.post(apiUrl, user);
            console.log("Response Data:", response.data);
            // Update the user data with the response from the server
            // this.$router.push('/UserPage');
          } catch (error) {
            console.error("An error occurred:", error.response);
          }
        },
        async getUserMeg(){
            // const user = {
               const user_id = this.user_id; // 确保这是有效的用户标识符

            // };
          const apiUrl = `http://127.0.0.1:9200/selectUser?id=${user_id}`;//变量请求
          try {
            const response = await axios.get(apiUrl);
            console.log("Response Data:", response.data);
            this.user_datas = response.data;

          } catch (error) {
            console.error("An error occurred:", error.response);
          }
        },
    },

    created() {
        this.getUserMeg();
    },
};
</script>
<style>

</style>