<script>
import axios from "axios";
export default {
    name: 'headerBar',
    data() {
        return {
            user_id: localStorage.getItem('user_id') || '', // 获取localStorage中的user_id
            productName:'',
            product_id:''
        };
    },
    methods: {
        logout() {
            // 清除localStorage中的user_id
            localStorage.clear();
            // 更新user_id的值，以触发导航链接的重新渲染
            this.user_id = '';
            // 自动刷新页面
            // window.location.reload();
        },
        searchProduct(event) {
            // 发送产品名称到后端
            event.preventDefault();
            console.log('input:',this.productName)
            axios.post('http://8.134.18.17:8081/searchShop', { productName: this.productName })
                .then(response => {
                    console.log('response:',response.data)
                    // 如果后端返回不为空，执行页面跳转操作
                    this.product_id = response.data.product_id;
                    if (response.data !== null && this.product_id !== undefined) {
                        // 如果后端返回不为空，执行页面跳转操作
                        this.product_id = response.data.product_id;
                        console.log('product_id:', this.product_id);
                        this.$router.push({ path: `/ProductSingle/${this.product_id}` });
                    } else {
                        // 如果后端返回为空，弹出警告框
                        alert('Can not find the product');
                    }
                })
                .catch(error => {
                    // 处理请求错误
                    console.error(error);
                });
        },
    },
};
</script>
<template>
<div>
    <nav class="navbar navbar-expand-lg bg-light">
        <div class="container-fluid">
            <router-link class="navbar-brand" to="/Index">Navbar</router-link>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <router-link class="nav-link active" aria-current="page" to="/Index">Home</router-link>
                    </li>
                    <li class="nav-item">
                        <router-link class="nav-link active" to="/ShopPage">Shop</router-link>
                    </li>
                    <li class="nav-item">
                      <router-link class="nav-link active" to="/ProductPump">Pump</router-link>
                    </li>
                    <li class="nav-item">
                        <router-link class="nav-link active" to="/FeedbackPage">Feedback</router-link>
                    </li>
                    <li class="nav-item">
                        <router-link class="nav-link active" to="/">About</router-link>
                    </li>
                </ul>
                <ul class="nav justify-content-end">
                    <!-- 使用v-if和v-else来根据user_id的值显示不同的链接 -->
                    <li class="nav-item">
                        <router-link v-if="user_id" class="nav-link active" @click="logout" to="/index">Login out</router-link>
                        <router-link v-else class="nav-link active" to="/login">Login</router-link>
                    </li>
                    <li class="nav-item" v-if="!user_id">
                        <router-link class="nav-link active" to="/SignUp">Signup</router-link>
                    </li>
                    <li class="nav-item dropdown" v-if="user_id">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Dropdown
                        </a>
                        <ul class="dropdown-menu">
                            <li><router-link class="dropdown-item" to="/CartPage">Cart</router-link></li>
                            <li><router-link class="dropdown-item" to="/OrderPage">Order</router-link></li>
                            <li><router-link class="dropdown-item" to="/UserPage">UserPage</router-link></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><router-link class="dropdown-item" to="/">Something else here</router-link></li>
                        </ul>
                    </li>
                </ul>
                <form class="d-flex" role="search">
                    <input v-model="productName" class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button @click="searchProduct" class="btn btn-outline-success" type="button">Search</button>
                </form>
            </div>
        </div>
    </nav>
</div>
</template>

<style>
.nav-item:not(:last-child) {
    margin-right: 15px; /* 调整右边距，根据需要修改值 */
}
</style>