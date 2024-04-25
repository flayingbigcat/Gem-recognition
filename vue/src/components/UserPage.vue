<template>
    <header-bar></header-bar>
    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-md-12 d-flex justify-content-center">
                    <div class="content">
                        <h1 class="page-name">Welcome</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><router-link style="text-decoration: none" to="/">Home</router-link></li>
                                <li class="breadcrumb-item active" aria-current="page">Order</li>
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
                <div class="pull-left mb-2">
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <router-link class="btn btn-outline-secondary me-md-2" to="/EditInfo">Edit Information ></router-link>
                    </div>
                    <img class="media-object user-img" v-if="user.user_imageSrc"
                         :src="require(`../assets/${user.user_imageSrc}`)">
                </div>
                <div class="media-body">
                    <h2 class="media-heading">{{ user.user_name }}</h2>
                    <p>{{user.user_description}}</p>
                </div>
            </div>
            <form class="row g-3">
                <div class="col-md-4">
                    <label for="inputEmail4" class="form-label">Sex</label>
                    <p>{{ user.user_sex }}</p>
                </div>
                <div class="col-4">
                    <label for="inputAddress" class="form-label">Email</label>
                    <p>{{ user.user_email }}</p>
                </div>
                <div class="col-6">
                    <label for="inputAddress2" class="form-label">PhoneNumber</label>
                    <p>{{user.user_phone}}</p>
                </div>
                <div class="col-md-12">
                    <label for="inputCity" class="form-label">Address</label>
                    <p>{{user.user_address}}</p>
                </div>
            </form>
        </div>
    </div>

    <footer-bar></footer-bar>
</template>

<script>
import HeaderBar from "@/components/HeaderBar.vue";
import FooterBar from "@/components/FooterPage.vue";
import axios from "axios";
// import { defineComponent, ref, onMounted } from 'vue';
// import axios from "axios";

export default{
    components: {FooterBar, HeaderBar},
    data() {
        return {
            // 从localStorage获取数据并初始化data属性
            user_id:localStorage.getItem('user_id'),
            user_imageSrc: 'user_8.jpg',
            user: [
            ],
        };
    },
    methods:{
        async getUserMeg(){
            // const user = {
            const user_id = this.user_id; // 确保这是有效的用户标识符
            console.log(user_id)

            // };
            const apiUrl = `http://8.134.18.17:8081/selectUser?id=${user_id}`;//变量请求
            try {
                const response = await axios.get(apiUrl);
                console.log("Response Data:", response.data);
                this.user = response.data;
                // 根据成功响应进行导航
                // this.$router.push('/UserPage');
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
@import "../css/_user.css";
</style>
