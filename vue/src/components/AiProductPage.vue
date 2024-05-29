<template>
    <div class="product">
        <div class="container">
            <div class="row">
                <div class="col-md-3" v-for="(product ) in displayedProducts" :key="product[0]">
                    <div class="product-item">
                        <div class="card text-center ">
                            <!-- 使用 require 导入图片 -->
<!--                            <img :src="require(`../assets/${product.product_imageSrc}`)" class="card-img-top" alt="">-->
                          <img :src="product[2]" class="card-img-top" alt="...">
                            <div class="card-body ">
                                <h5 class="card-title">{{ product[1] }}</h5>
                                <h5 class="card-text">{{product[3]}}</h5>
<!--                                <p class="card-text">{{ product.product_description }}</p>-->
                                <div class="d-grid gap-2 d-md-flex justify-content-center">
                                    <router-link :to="`/ProductSingle/${product[0]}`" class="btn btn-dark me-md-2">查看</router-link>
                                    <button class="btn btn-info" type="button" @click="addToCart(product[0],product[1],product[3],product[2])">收藏</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 使用 Bootstrap 样式的分页 -->
            <nav aria-label="Page navigation example" class="d-flex justify-content-center mt-4">
                <ul class="pagination">
                    <li class="page-item" :class="{ 'disabled': currentPage === 1 }">
                        <router-link class="page-link" to="#" aria-label="Previous" @click.prevent="prevPage">
                            <span aria-hidden="true">&laquo;</span>
                        </router-link>
                    </li>
                    <li class="page-item" v-for="page in totalPages" :key="page" :class="{ 'active': currentPage === page }">
                        <router-link class="page-link" to="#" @click.prevent="gotoPage(page)">{{ page }}</router-link>
                    </li>
                    <li class="page-item" :class="{ 'disabled': currentPage === totalPages }">
                        <router-link class="page-link" to="#" aria-label="Next" @click.prevent="nextPage">
                            <span aria-hidden="true">&raquo;</span>
                        </router-link>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</template>

<script>
import axios from "axios";
export default {
    name: 'AiProductList',
    data() {
        return {
          Gem_pictures:[],
            products: [
                // {
                //     product_id:'1',
                //     product_name:'Card title',
                //     product_description:'Some quick example text to build on the card title and make up the bulk of the card\'s content.',
                //     product_imageSrc:'product_1.jpg'
                // }
            ],
            currentPage: 1,
            pageSize: 12, // 每页显示数量
        };
    },
    created() {
        // Make an HTTP request to the backend API endpoint
        axios.get('http://127.0.0.1:9200/get_aishops?query_type=all')
            .then(response => {
                // Update the products array with the data received from the backend
                console.log(response.data);
                console.log("user_id",localStorage.getItem('user_id'));
                this.products = response.data;
            })
            .catch(error => {
                console.error('Error fetching data from the backend:', error);
            });
    },
    computed: {
      // 计算索引，第一页从0开始，第二页从9开始，第三页从18开始，以此类推
      startIndex() {
        return (this.currentPage - 1) * this.pageSize;
      },
      // 计算显示的产品列表
      displayedProducts() {
        return this.products.slice(this.startIndex, this.startIndex + this.pageSize);
      },
      // 计算总页数
      totalPages() {
        return Math.ceil(this.products.length / this.pageSize);
      },
    },
  methods: {
        // 上一页按钮点击事件
        prevPage() {
            if (this.currentPage > 1) {
                this.currentPage--;
            }
        },
        // 下一页按钮点击事件
        nextPage() {
            if (this.currentPage < this.totalPages) {
                this.currentPage++;
            }
        },
        // 跳转到指定页码
        gotoPage(page) {
            this.currentPage = page;
        },
    addToCart(productId, productName, productPrice, product_imageSrc) {
      // 假设 user_id 存储在 Vue 实例的某个属性中，比如 this.userId
      const user_id = localStorage.getItem('user_id');

      // 发送 POST 请求到后端
      axios.post('http://127.0.0.1:9200/add_to_cart', {
        product_id: productId,
        product_name: productName,
        product_price: productPrice,
        user_id: user_id,
        product_imageSrc: product_imageSrc
      })
          .then(response => {
            // 处理后端返回的响应
            if (response.data.success) {
              // 处理成功的情况
              this.$message.success('收藏成功');
            } else {
              // 处理失败的情况
              this.$message.error('收藏失败: ' + (response.data.error || '未知错误'));
            }
          })
          .catch(error => {
            // 处理网络错误等异常
            console.error('Error adding to cart:', error);
            this.$message.error('收藏失败: ' + (error.response?.data?.error || '网络错误'));
          });
    },
  }
};
</script>

<style>
@import "../css/_common.css";
/* 可添加自定义样式 */
</style>
