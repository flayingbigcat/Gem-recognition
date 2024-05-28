<template>
    <div>
        <header-bar></header-bar>
    </div>
    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="content">
                        <h1 class="page-name">商城</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><router-link style="text-decoration: none" to="/">首页</router-link></li>
                                <li class="breadcrumb-item active" aria-current="page">宝石商城</li>
                                <li class="breadcrumb-item"><router-link style="text-decoration: none" to="/AiCreateImage">宝石创作</router-link></li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <product-list></product-list>
</template>
<script>
import HeaderBar from "@/components/HeaderBar.vue";
import { defineComponent } from "vue";
import ProductList from "@/components/ProductPage.vue";

export default defineComponent({
    components: {ProductList,  HeaderBar }
})
</script>
<style>
@import "../css/_common.css";
</style>