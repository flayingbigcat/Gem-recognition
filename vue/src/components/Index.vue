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
                  <h5 style="font-size: 55px">{{ titles[index % 3] }}</h5> <!-- 使用数组的索引，确保在3个标题中循环 -->
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
    <div class="container-fluid" style="padding: 10px">
      <div class="row justify-content-center">
        <div class="col-md-4">
          <div class="text-align: center;">
            <img :src="'data:image;base64,' + images_product[9]" alt="" class="w-75" style="margin: auto; display: block;"/>
          </div>
        </div>
        <div class="col-md-5" style="padding: 20px;">
          <h3 style="font-size: 45px">烈焰石</h3>
          <p style="font-size: 25px">烈焰石是一种稀有的矿物，其独特之处在于其深红色的晶体表面覆盖着一层闪闪发光的白色晶簇。这种矿石只在地球深处的火山岩层中发现，其形成过程被认为与火山喷发活动密切相关。</p>
        </div>
      </div>
      <div class="row justify-content-center" style="padding: 20px">
        <div class="col-md-5 " style=" text-align: right">
          <h3 style="font-size: 45px">翡墨石</h3>
          <p style="font-size: 25px">翡墨石，一种令人惊叹的自然奇观，它将翠绿与漆黑融为一体。这种矿石稀世罕见，仅在地球深处的神秘矿脉中闪耀。其外观恰如森林中的密林，绿叶与黑影交错，散发出一种神秘的气息。</p>
        </div>
        <div class="col-md-4">
          <div class="text-align: center;" >
            <img :src="'data:image;base64,' + images_product[5]" alt="" class="w-75" style="margin: auto; display: block;"/>
          </div>
        </div>
      </div>
      <div class="row justify-content-center">
        <div class="col-md-4">
          <div class="text-align: center;">
            <img :src="'data:image;base64,' + images_product[2]" alt="" class="w-75" style="margin: auto; display: block;"/>
          </div>
        </div>
        <div class="col-md-5" style="padding: 20px;">
          <h3 style="font-size: 45px">瑪瑙石</h3>
          <p style="font-size: 25px">琥珀晶是一种迷人而神秘的矿石，其色泽呈现出温暖的棕色，微微透明，仿佛蕴藏着岁月的记忆和大地的温情。这种独特的矿物宝石隐藏在地球深处的古老岩层中，常常伴随着古代生物的痕迹，成为了地质学和珠宝学的珍品。</p>
        </div>
      </div>
    </div>
    <div class="product">
        <div class="container">
            <div class="row">
                <div class="title text-center">
                    <h2 style="font-size: 35px">精美宝石</h2>
                </div>
            </div>
          <div class="row">
            <div class="col-md-4" v-for="(product, index) in products" :key="product.product_id" >

              <div class="product-item">
                <div class="product-thumb">
                  <img class="img-responsive img-fluid"
                       :src="'data:image;base64,' + images_product[index]" alt="product-img" />
                </div>
              </div>

              <div class="product-content">
                <h4><router-link :to="`/ProductSingle/${product[0]}`">{{ product[1] }}</router-link></h4>
                <p class="price">{{ product[2] }}</p>
              </div>

            </div>
          </div>
        </div>
    </div>

  <div class="hello">
  </div>
</template>

<script>
import headerBar from "@/components/HeaderBar.vue";

import axios from "axios";
export default {
  name: 'HelloWorld',
    components: {
        headerBar, // 注册导航条组件
    },
    data() {
        return {
          titles:["宝石设计之美 探索无限", "宝石设计之旅 探索创意", "宝石设计之美 璀璨之路"],
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
        axios.get('http://127.0.0.1:9200/get_shops?query_type=top_9')
            .then(response => {
                // Update the products array with the data received from the backend
                this.products = response.data;
              console.log(this.products);
                console.log(response.data);
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
        axios.get('http://127.0.0.1:9200/uploadimg/carousel').then((res)=>{
          console.log(res)
          this.images = res.data;
          // this.$message.success('图片获取成功');
          console.log('图片获取成功');
        }).catch(()=>{
          // this.$message.error('图片获取失败');
          console.log('图片获取失败');
        })
      },
    gain_product(){
      axios.get('http://127.0.0.1:9200/uploadimg/product').then((res)=>{
        console.log(res)
        this.images_product = res.data;
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
