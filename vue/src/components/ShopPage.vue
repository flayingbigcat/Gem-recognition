<template>
    <div>
        <header-bar></header-bar>
    </div>
    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="content">
                        <h1 class="page-name">Shop</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><router-link style="text-decoration: none" to="/">Home</router-link></li>
                                <li class="breadcrumb-item active" aria-current="page">Shop</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <product-list></product-list>
    <footer-bar></footer-bar>
</template>
<script>
import HeaderBar from "@/components/HeaderBar.vue";
import { defineComponent } from "vue";
import FooterBar from "@/components/FooterPage.vue";
import ProductList from "@/components/ProductPage.vue";

export default defineComponent({
    components: {ProductList, FooterBar, HeaderBar }
})
</script>
<style>
@import "../css/_common.css";
</style>