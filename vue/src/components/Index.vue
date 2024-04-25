<template>
    <div>
        <header-bar></header-bar>
    </div>
    <div class="TopPicture h-75">
        <div id="carouselExampleCaptions" class="carousel slide mx-auto w-75" data-bs-ride="carousel" >
          <button
              v-for="(indicator, index) in carouselIndicators"
              :key="index"
              type="button"
              :data-bs-target="'#carouselExampleCaptions'"
              :data-bs-slide-to="index"
              :class="{ 'active': index === 0 }"
              aria-label="Slide {{ index + 1 }}"
              aria-current="true"
          ></button>
            <div class="carousel-inner">
              <div v-for="(image, index) in images" :key="index" :class="{ 'carousel-item': true, 'active': index === 0 }" data-bs-interval="3000">
                <img :src="'data:image;base64,' + image" class="d-block w-100" alt="...">
                <div class="carousel-caption d-block">
                  <h5>{{ '第 ' + (index + 1) + ' 张图片' }}</h5>
                  <p>第 {{ index + 1 }} 张图片的占位内容。</p>
                </div>
              </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
    <div class="mid">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="title text-center">
                        <h2>Product Category</h2>
                    </div>
                </div>
              <div class="col-md-6 ">
                <div class="category-box ">
                  <router-link to="#">
                    <img :src="'data:image;base64,' + images_product[9]" alt="" />
                    <div class="content">
                      <h3>Formula One</h3>
                      <p>Super Faster and Super Power</p>
                    </div>
                  </router-link>
                </div>
                <div class="category-box w-75 " style="margin-left: auto;">
                  <router-link to="#">
                    <img :src="'data:image;base64,' + images_product[10]" alt="" />
                    <div class="content">
                      <h3>Lamborghini Aventador</h3>
                      <p>Get Wide Range Selection</p>
                    </div>
                  </router-link>
                </div>
              </div>
              <div class="col-md-6 d-flex align-items-center">
                <div class="category-box category-box-2 w-75">
                  <router-link to="#">
                    <img :src="'data:image;base64,' + images_product[11]" alt="" />
                    <div class="content">
                      <h3>Lamborghini_Aventador</h3>
                      <p>Special Design Comes First</p>
                    </div>
                  </router-link>
                </div>
              </div>
            </div>
        </div>
    </div>
    <div class="product">
        <div class="container">
            <div class="row">
                <div class="title text-center">
                    <h2>Trendy Products</h2>
                </div>
            </div>
          <div class="row">
            <div class="col-md-4" v-for="(product, index) in products" :key="product.product_id" >
              <div class="product-item">
                <div class="product-thumb">
                  <!-- 从第4张图片开始读取 -->
                  <img class="img-responsive img-fluid"
                       :src="'data:image;base64,' + images_product[index]" alt="product-img" />
                </div>
              </div>
              <div class="product-content">
                <h4><router-link :to="`/ProductSingle/${product.product_id}`">{{ product.product_name }}</router-link></h4>
                <p class="price">{{ product.product_price }}</p>
              </div>
            </div>
          </div>
        </div>
    </div>
    <div class="call-to-action bg-gray section">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <div class="title">
                        <h2>SUBSCRIBE TO NEWSLETTER</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fugiat, <br> facilis numquam impedit ut sequi. Minus facilis vitae excepturi sit laboriosam.</p>
                    </div>
                    <div class="input-group input-group-lg mb-3 w-50 m-auto">
                        <input type="text" class="form-control" placeholder="Enter Your Email Address" aria-label="Recipient's username" aria-describedby="button-addon2">
                        <button class="btn btn-dark" type="button">Subscribe Now!</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="instagram-feed">
        <div class="container">
            <div class="row">
                <div class="title">
                    <h2>View us on instagram</h2>
                </div>
            </div>
        </div>
    </div>
    <footer-bar></footer-bar>
  <div class="hello">
  </div>
</template>

<script>
import headerBar from "@/components/HeaderBar.vue";
import FooterBar from "@/components/FooterPage.vue";
import axios from "axios";
export default {
  name: 'HelloWorld',
    components: {
        FooterBar,
        headerBar, // 注册导航条组件
    },
    data() {
        return {
          images: [], // 存储从后端接收到的图片数据
          images_product:[],
          carouselIndicators: [], // 存储轮播指示器数据
          product_imageSrc:'product_1.jpg',
          products: [
                // Add other product entries here
          ]
        };
    },
    created() {
        axios.post('http://127.0.0.1:8081/selectShop2')
            .then(response => {
                // Update the products array with the data received from the backend
                this.products = response.data;
                console.log(response.data);
                console.log(response.data.product_imageSrc);
            })
            .catch(error => {
                console.error('Error fetching data from the backend:', error);
            });
    },
    mounted() {
      this.gain();
      this.calculateIndicators();
      this.gain_product();
    },
  methods:{
      gain(){
        axios.get('http://localhost:8081/file/images').then((res)=>{
          console.log(res)
          this.images = res.data.data;
          // this.$message.success('图片获取成功');
          console.log('图片获取成功');
        }).catch(()=>{
          // this.$message.error('图片获取失败');
          console.log('图片获取失败');
        })
      },
    gain_product(){
      axios.get('http://localhost:8081/file/Product_images').then((res)=>{
        console.log(res)
        this.images_product = res.data.data;
        // this.$message.success('图片获取成功');
        console.log('图片获取成功');
      }).catch(()=>{
        // this.$message.error('图片获取失败');
        console.log('图片获取失败');
      })
    },
    // 计算轮播指示器的数量
    calculateIndicators() {
      // 假设你有一个 images 数组存储了图片数据
      this.carouselIndicators = Array.from({ length: this.images.length }, (_, index) => index);
    }
    }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.TopPicture {
    padding-bottom: 80px;
}
.carousel-inner {
    /* 设置内部图片的宽度和高度 */
    width: 100%;
    height: 100%;
}

.carousel-caption {
    color: white; /* 文字颜色 */
    /* 调整文字位置，可以根据需要修改下面的属性值 */
    position: absolute;
    top: 50%; /* 从顶部位置的百分比 */
    left: 50%; /* 从左侧位置的百分比 */
    transform: translate(-50%, -50%); /* 用于将元素居中 */
}
.carousel-caption h5 {
    font-size: 36px; /* 调整标题字体大小 */
}
.carousel-caption p {
    color: white;
    font-size: 24px; /* 调整描述字体大小 */
}
.carousel-item.active .carousel-caption h5,
.carousel-item.active .carousel-caption p {
    opacity: 1; /* 当元素在 active 状态时，透明度为 1，即不透明 */
}
.carousel-caption h5{
    opacity: 0; /* 初始状态为透明 */
    transition: opacity 1.5s ease-in-out; /* 添加渐显的过渡效果 */
}
.carousel-caption p {
    opacity: 0; /* 初始状态为透明 */
    transition: opacity 2.5s ease-in-out; /* 添加渐显的过渡效果 */
}
.product{
    padding: 80px;
}
.product-item{
    margin-bottom: 30px;
}
.product-thumb{
    position: relative;
}
.product-item .product-thumb {
    position: relative;
}
.product-content h4 a {
    color: #000;
    text-decoration: none;
}
.product-content h4 {
    font-size: 16px;
    font-weight: 400;
    margin-top: 15px;
    margin-bottom: 6px;
}
.mid{
    padding: 80px 0;
}
.title {
    padding: 20px 0 30px;
}
.text-center {
    text-align: center;
}
.title h2 {
    font-size: 18px;
    text-align: center;
    text-transform: uppercase;
    letter-spacing: 2px;
}
.category-box {
    background-size: cover;
    margin-bottom: 30px;
    min-height: 250px;
    position: relative;
    overflow: hidden;
    width: 100%;
}
.category-box.category-box-2 {
    min-height: 450px;
    margin-bottom: 0px;
}
.category-box .content {
    position: absolute;
    z-index: 999;
    top: 0;
    padding: 25px;
}
.category-box .content h3 {
    margin: 0;
    color: #333;
    font-size: 20px;
    font-weight: 500;
}
.category-box .content p {
    margin: 6px 0 0;
}
.category-box img {
    transition: all 0.3s ease-in-out;
    width: 100%;
    height: auto;
    -webkit-backface-visibility: hidden;
    backface-visibility: hidden;
}
.category-box:hover img {
    transform: scale(1.2); /* 鼠标悬停时放大图像 */
}
/* .call-to-action */
.call-to-action {
    padding: 80px;
    /* .subscription-form */
}

/* @include mobile */
.call-to-action .subscription-form {
    display: block;
}

/* input */
.call-to-action .subscription-form input {
    height: 50px;
}

/* @include mobile */
.call-to-action .subscription-form input {
    text-align: center;
}

/* .btn-main */
.call-to-action .subscription-form .btn-main {
    font-size: 14px;
}

/* @include mobile */
.call-to-action .subscription-form .btn-main {
    width: 100%;
}
.call-to-action .subscription-form input {
    height: 50px;
}
.form-control {
    box-shadow: none;
    border-radius: 0;
    &:focus {
        box-shadow:none;
        border:1px solid $primary-color;
    }
}
.instagram-feed {
    text-align: center;
    padding: 80px;
}
.instagram-feed a {
    margin: 6px;
    margin-right: 10px;
    margin-bottom: 10px;
    display: flex;
    align-items: center;
}
.instagram-feed a:hover img {
    filter: grayscale(10);
}
.instagram-feed a img {
    width: 100%;
    max-height: 180px;
    -o-object-fit: cover;
    object-fit: cover;
}
</style>
