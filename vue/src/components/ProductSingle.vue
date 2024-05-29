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
                            <li class="breadcrumb-item"><router-link to="/index" style="text-decoration: none;">首页</router-link></li>
                            <li class="breadcrumb-item active" aria-current="page">商城</li>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="row mt-20">
                <div class="col-md-5">
                    <div class="single-product-slider">
                        <div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active" data-bs-interval="2000">
                                    <img v-if="product_imageSrc"
                                         :src="product[3]" class="d-block w-100">
                                </div>
                                <div class="carousel-item" data-bs-interval="2000">
                                    <img v-if="product_imageSrc1"
                                         :src="product[5]" class="d-block w-100">
                                </div>
                                <div class="carousel-item" data-bs-interval="2000">
                                    <img v-if="product_imageSrc2"
                                         :src="product[6]" class="d-block w-100">
                                </div>
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
                        <h2>{{product[1]}}</h2>
                        <p class="product-price">{{product[2]}}</p>

                        <p class="product-description mt-20">{{product[4]}}</p>
                        <div class="color-swatches">
                            <span>颜色:</span>
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
                            <span>尺寸:</span>
                            <select class="form-control">
                                <option>99</option>
                                <option>98</option>
                                <option>85</option>
                            </select>
                        </div>
                        <div class="product-quantity">
                            <span>数量:</span>
                            <div class="quantity-modifier">
                                <button @click="changeQuantity(-1)">-</button>
                                <input v-model="quantity" type="text" name="product-quantity">
                                <button @click="changeQuantity(1)">+</button>
                            </div>
                        </div>
                        <button class="btn btn-info mt-20" type="button" @click="addToCart">购买</button>
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
          product:[],
            quantity: 1, // 初始化为1
            product_imageSrc:'product_1.jpg',
            product_imageSrc1:'product_2.jpg',
            product_imageSrc2:'product_3.jpg',
            product_name:'',
            product_price:'',
            product_description1:'',
            localProductId: this.$route.params.productId // 使用本地 data 属性
        };
    },
    created() {
        this.loadProductData()
    },
    methods: {
        changeQuantity(change) {
            let newQuantity = this.quantity + change;
            if (newQuantity >= 0) { // 确保数量不小于0
                this.quantity = newQuantity;
            }
        },
      loadProductData() {
        if (this.localProductId) {
          let url = '';
          if (this.localProductId.startsWith('gem_')) {
            // 如果 localProductId 以 "gem_" 开头，使用不同的 URL
            url = 'http://127.0.0.1:9200/get_aishops?query_type=by_id&product_id=' + this.localProductId;
          } else {
            url = 'http://127.0.0.1:9200/get_shops?query_type=by_id&product_id=' + this.localProductId;
          }

          // 发送GET请求，将product_id作为查询参数传递
          axios.get(url)
              .then(response => {
                // 请求成功，处理返回的数据
                console.log(response.data)
                this.product = response.data[0]
                console.log(this.product)
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