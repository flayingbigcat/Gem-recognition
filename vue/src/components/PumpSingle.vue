<template>
  <header-bar></header-bar>
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
            <div class="container">
              <div style="max-width: 1241px; max-height: 775px;">
                <div style="left: 0px; width: 100%; height: 0px; position: relative; padding-bottom: 62.4496%; overflow: hidden;">
                  <iframe src="/static/Pump_1.html"
                          id="ssss"
                          allowfullscreen
                          style="position: absolute; top: 0px; left: 0px; height: 100%; width: 1px; min-width: 100%; *width: 100%;"
                          frameborder="0"
                          scrolling="no">
                  </iframe>
                </div>
              </div>
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
            <button class="btn btn-info mt-20" type="button">put cart</button>
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

export default {
  name:'PumpSingle',
  components: {FooterBar, HeaderBar},
  data() {
    return {
      product_name: 'omni-Kiwi',
      product_price: '8597$',
      product_description1: 'Navicat provides powerful tools for working with queries: Query Editor for editing the query text directly, and Query Builder, Find Builder or Aggregate Builder for building queries visually. Genius is an infinite capacity for taking pains. Navicat authorizes you to make connection to remote servers running on different platforms',
    };
  },
}
</script>

<style scoped>
/* 这里添加样式 */
/* 样式应该与原始HTML中的样式相匹配 */
</style>
