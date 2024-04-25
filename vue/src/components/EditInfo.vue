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
                <div class="pull-left">
                    <img class="media-object user-img" :src="require(`../assets/${user_imageSrc}`)" alt="Image">
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
                    <h2 class="media-heading">userName</h2>
                    <input class="form-control media-heading" v-model="user_name" id="userNameInput" placeholder="User Name">
                    <p>user_description</p>
                    <input class="form-control" v-model="user_description" id="userEmailInput" placeholder="Description">
                </div>
            </div>
            <form class="row g-3 mt-1">
                <div class="col-md-4">
                    <label for="inputEmail4" class="form-label">Sex</label>
                    <input class="form-control" v-model="user_sex" id="userSexInput" placeholder="Sex">
                </div>
                <div class="col-4">
                    <label for="inputAddress" class="form-label">Email</label>
                    <p>{{ user_email }}</p>
                </div>
                <div class="col-6">
                    <label for="inputAddress2" class="form-label">PhoneNumber</label>
                    <input class="form-control" v-model="user_phone" id="userPhoneInput" placeholder="Phone Number">
                </div>
                <div class="col-md-12">
                    <label for="inputCity" class="form-label">Address</label>
                    <div class="col-md-6">
                        <input class="form-control" v-model="user_address" id="userAddressInput" placeholder="Address">
                    </div>
                </div>
            </form>
            <div class="d-grid gap-2 col-2 mx-auto mt-3">
                <router-link class="btn btn-outline-secondary me-md-2" to="UserPage" @click="updateUser">Save</router-link>
            </div>
        </div>
    </div>

    <footer-bar></footer-bar>
</template>


<script>
// import {defineComponent} from 'vue'
import HeaderBar from "@/components/HeaderBar.vue";
import FooterBar from "@/components/FooterPage.vue";
import axios from 'axios';


export default {
    name: "EditInfo",
    components: { HeaderBar, FooterBar },
    data() {
        return {
            // 从localStorage获取数据并初始化data属性
            user_id:localStorage.getItem('user_id'),
            user_sex:'',
            user_name:'',
            user_email:'',
            user_address:'',
            user_phone:'',
            user_description:'',
            user_imageSrc: localStorage.getItem('user_imageSrc') || 'user_8.jpg', // 设置默认值为 'user_8.jpg'
        };
    },
    methods:{
        async updateUser() {
            const user = {
                user_id: this.user_id, // 确保这是有效的用户标识符
                user_name: this.user_name,
                user_email: this.user_email,
                user_address: this.user_address,
                user_phone: this.user_phone,
                user_sex: this.user_sex,
                user_description: this.user_description,
                user_imageSrc: this.user_imageSrc,
            };

            const apiUrl = "http://8.134.18.17:8081/reviseUser"; // 后端的接口地址

            try {
                const response = await axios.post(apiUrl, user);
                console.log("Response Data:", response.data);
                this.$router.push('/UserPage');
            } catch (error) {
                console.error("An error occurred:", error.response);
            }
        },
        async getUserMeg(){
            // const user = {
               const user_id = this.user_id; // 确保这是有效的用户标识符

            // };
            const apiUrl = `http://8.134.18.17:8081/selectUser?id=${user_id}`;
            try {
                const response = await axios.get(apiUrl);
                console.log("Response Data:", response.data);
                this.user_name = response.data.user_name;
                this.user_email = response.data.user_email;
                this.user_address = response.data.user_address;
                this.user_phone = response.data.user_phone;
                this.user_sex = response.data.user_sex;
                this.user_description = response.data.user_description;
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

</style>