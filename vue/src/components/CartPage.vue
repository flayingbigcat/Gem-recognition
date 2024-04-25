<template>
    <div>
        <header-bar></header-bar>
    </div>
    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="content">
                        <h1 class="page-name">Cart</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <router-link style="text-decoration: none" to="/">Home</router-link>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">Cart</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="dashboard-Cart">
            <div class="media-body">
                <h2 class="media-heading">{{ user_name }}</h2>
            </div>
            <table class="table">
                <thead class="table-group-divider">
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Product</th>
                    <th scope="col">Price</th>
                    <th scope="col">Action</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="(item, index) in dataCollection" :key="item.id">
                    <td>{{ item.product_id }}</td>
                    <td>{{ item.product_name }}</td>
                    <td>{{ item.product_price }}</td>
                    <td>
                        <a class="no-underline-black" @click="deleteRow(index, item.product_id)">Remove</a>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="d-md-flex justify-content-md-end">
                <button class="btn btn-dark" type="button">Checkout</button>
            </div>
        </div>
    </div>
    <footer-bar></footer-bar>
</template>
<script>
import HeaderBar from "@/components/HeaderBar.vue";
// import {defineComponent} from "vue";
import FooterBar from "@/components/FooterPage.vue";
import axios from "axios";
export default {
    components: { FooterBar, HeaderBar },
    data() {
        return {
            user_name:localStorage.getItem('user_name'),
            dataCollection: [
                {
                    product_id:'',
                    product_name:'',
                    product_price:''
                }
            ]
        };
    },
    mounted() {
        // 获取存储在localStorage的user_id
        const userId = localStorage.getItem('user_id');
        if (!userId) {
            // 如果userId为空，执行路由导航到登录页面
            this.$router.push("/login");
        }
        console.log(userId);
        // 在组件加载后发送HTTP请求
        axios.post('http://8.134.18.17:8081/selectProduct', { user_id: userId }) // 发送POST请求，传递一个对象作为请求体
            .then(response => {
                console.log(response.data);
                this.dataCollection = response.data; // 将后端数据填充到dataCollection数组中
                // if (response.data.length > 0) {
                //     this.product_id = response.data[0].product_id;
                //     localStorage.setItem('product_id', this.product_id);
                // }
                // console.log( localStorage.getItem('product_id'))
                // 打印product_id数据
            })
            .catch(error => {
                console.error('User ID is not available', error);
            });
    },

    methods: {
        // 删除行的方法
        deleteRow(index, productId) {
            // 从前端数据中删除行
            this.dataCollection.splice(index, 1);
            const deletedProductId = productId;
            // 发送删除请求到后端接口
            axios.post(`http://8.134.18.17:8081/deleteProduct?id=${productId}`)
                .then(() => {
                    // 处理后端删除成功的响应
                    console.log('Data deleted successfully from the backend Deleted product',deletedProductId);
                })
                .catch(error => {
                    console.error('Error deleting data from the backend:', error);
                });
        }
    }
};

</script>
<style>
@import "../css/_product.css";
@import "../css/_common.css";
</style>