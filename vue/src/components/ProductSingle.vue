<template>
    <div>
        <header-bar></header-bar>
    </div>
    <div class="single-product">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><router-link to="/index" style="text-decoration: none;">Home</router-link></li>
                            <li class="breadcrumb-item active" aria-current="page">Library</li>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="row mt-20">
                <div class="col-md-5">
                    <div class="single-product-slider">
                        <div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                              <div v-for="(Gem_img, index) in 3" :key="index" :class="{ 'carousel-item': true, 'active': index === 0 }" data-bs-interval="3000">
                                <img :src="'data:image;base64,' + Gem_img[productId]" class="d-block w-100" alt="...">

                              </div>
<!--                                <div class="carousel-item active" data-bs-interval="2000">-->
<!--                                    <img v-if="product_imageSrc"-->
<!--                                         :src="require(`../assets/${product_imageSrc}`)" class="d-block w-100">-->
<!--                                </div>-->
<!--                                <div class="carousel-item" data-bs-interval="2000">-->
<!--                                    <img v-if="product_imageSrc1"-->
<!--                                         :src="require(`../assets/${product_imageSrc1}`)" class="d-block w-100">-->
<!--                                </div>-->
<!--                                <div class="carousel-item" data-bs-interval="2000">-->
<!--                                    <img v-if="product_imageSrc2"-->
<!--                                         :src="require(`../assets/${product_imageSrc2}`)" class="d-block w-100">-->
<!--                                </div>-->
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-7">
                    <div class="single-product-details">
                        <h2>{{product_name}}</h2>
                        <p class="product-price">{{product_price}}</p>

                        <p class="product-description mt-20">{{product_description1}}</p>
                        <div class="color-swatches">
                            <span>color:</span>
                            <ul>
                                <li>
                                    <a href="#!" class="swatch-violet"></a>
                                </li>
                                <li>
                                    <a href="#!" class="swatch-black"></a>
                                </li>
                                <li>
                                    <a href="#!" class="swatch-cream"></a>
                                </li>
                            </ul>
                        </div>
                        <div class="product-size">
                            <span>Size:</span>
                            <select class="form-control">
                                <option>99</option>
                                <option>98</option>
                                <option>85</option>
                            </select>
                        </div>
                        <div class="product-quantity">
                            <span>Quantity:</span>
                            <div class="quantity-modifier">
                                <button @click="changeQuantity(-1)">-</button>
                                <input v-model="quantity" type="text" name="product-quantity">
                                <button @click="changeQuantity(1)">+</button>
                            </div>
                        </div>
                        <button class="btn btn-info mt-20" type="button" @click="addToCart">put cart</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer-bar></footer-bar>
</template>
<script>

import HeaderBar from "@/components/HeaderBar.vue";
import FooterBar from "@/components/FooterPage.vue";
import axios from "axios";
export default {
    name: "ProductSingle",
    components: {FooterBar, HeaderBar},
    props: ['productId'],
    data() {
        return {
            Gem_img:[],
            quantity: 1, // 初始化为1
            product_imageSrc:'product_1.jpg',
            product_imageSrc1:'product_2.jpg',
            product_imageSrc2:'product_3.jpg',
            product_name:'',
            product_price:'',
            product_description1:'',
            localProductId: this.$route.params.product_id, // 使用本地 data 属性
        };
    },
    created() {
        this.loadProductData();
    },
    methods: {
        changeQuantity(change) {
            let newQuantity = this.quantity + change;
            if (newQuantity >= 0) { // 确保数量不小于0
                this.quantity = newQuantity;
            }
        },
        loadProductData() {
            if (this.productId) {
                // 创建一个对象来发送 id 参数
                const params = new URLSearchParams();
                params.append('id', this.productId);

                axios.post('http://8.134.18.17:8081/selectShop1', params)
                    .then(response => {
                        // 请求成功，处理返回的数据
                        console.log(response.data)
                        const product = response.data;
                        this.product_name = product.product_name;
                        this.product_price = product.product_price;
                        this.product_description1 = product.product_description1;
                        this.product_imageSrc = product.product_imageSrc;
                        this.product_imageSrc1 = product.product_imageSrc1;
                        this.product_imageSrc2 = product.product_imageSrc2;
                    })
                    .catch(error => {
                        // 请求失败，打印错误信息
                        console.error('Error fetching product data:', error);
                    });
            } else {
                // productId 未定义，打印错误信息
                console.error('Product ID is undefined');
            }
        },
        addToCart() {
            // 获取user_id
            const userId = localStorage.getItem('user_id');

            // 检查user_id是否为空
            if (!userId) {
                // user_id为空，跳转到登录页面
                this.$router.push('/login');
                return; // 退出方法执行
            }
            // 构建要发送到后端的商品信息对象
            const shopCartItem = {
                user_id: localStorage.getItem('user_id'),// 假设用户ID存储在localStorage
                product_id: this.localProductId,
                product_name: this.product_name, // 修改这里
                product_price:  this.product_price // 和这里
            };
            console.log("Adding to cart:", shopCartItem);
            // 发送POST请求到后端
            axios.post('http://8.134.18.17:8081/addShopCart', shopCartItem)
                .then(response => {
                    // 处理响应
                    console.log("Item added to cart successfully", response);
                    alert("Item added to cart successfully");
                })
                .catch(error => {
                    // 处理错误
                    console.error("There was an error adding the item to the cart:", error);
                });
        },
    }
}
</script>

<style>
@import "../css/_product.css";
</style>