<template>
  <header-bar></header-bar>
  <div class="container-fluid">
    <div class="row">
      <div class="col text-center">
        <h2>AI创作</h2>
      </div>
    </div>
    <div class="row">
      <div class="col-md-2">
        <!-- 左侧内容 -->
        <label>历史记录</label>
        <el-collapse v-model="activeName" accordion>
          <template v-for="item in allData" :key="item.name">
            <el-collapse-item :title="item[1]" :name="item.name">
              <div>
                <p>提示词: {{ item[3] }}</p>
                <p>反向提示词: {{ item[4] }}</p>
                <p>迭代次数: {{ item[5] }}</p>
                <p>宽度: {{ item[6] }}</p>
                <p>高度: {{ item[7] }}</p>
              </div>
            </el-collapse-item>
          </template>
        </el-collapse>
      </div>
      <div class="col-md-6">
        <!-- 中间内容 -->
        <div>
          <input type="file" @change="handleGeneratedFileUpload">
          <div >
            <img v-if="uploadedImage" :src="uploadedImage" class="uploaded-image"  >
          </div>
        </div>
        <div>
          <label class="form-label">提示词</label>
          <textarea class="form-control" id="prompt" v-model="prompt" rows="2" placeholder="请输入提示词"></textarea>
          <el-row class="p-2">
            <el-button round @click="addToPrompt('戒指')">戒指</el-button>
            <el-button type="primary" round @click="addToPrompt('bracelet')">手链</el-button>
            <el-button type="success" round @click="addToPrompt('bangle')">手镯</el-button>
            <el-button type="info" round @click="addToPrompt('pendant')">吊坠</el-button>
            <el-button type="warning" round @click="addToPrompt('necklace')">项链</el-button>
            <el-button type="danger" round @click="addToPrompt('brooch')">胸针</el-button>
            <el-button type="success" round @click="addToPrompt('drop earrings')">耳坠</el-button>
            <el-button type="primary" round @click="addToPrompt('hoop earrings')">圆形耳环</el-button>
            <el-button type="info" round @click="addToPrompt('corsage')">胸花</el-button>
            <el-button type="warning" round @click="addToPrompt('jewelry')">珠宝首饰</el-button>
          </el-row>
        </div>
        <div>
          <label class="form-label">反向提示词</label>
          <textarea id="negativePrompt" v-model="negative_prompt" class="form-control" placeholder="请输入反向提示词"></textarea>
          <el-row class="p-2">
            <el-button round @click="addToNegativePrompt('Low quality')">低质量</el-button>
            <el-button type="primary" round @click="addToNegativePrompt('expensive')">昂贵</el-button>
            <el-button type="success" round @click="addToNegativePrompt('outdated')">过时</el-button>
            <el-button type="info" round @click="addToNegativePrompt('damaged')">破损</el-button>
            <el-button type="warning" round @click="addToNegativePrompt('stolen')">失窃</el-button>
            <el-button type="danger" round @click="addToNegativePrompt('exaggerated')">过于浮夸</el-button>
            <el-button type="success" round @click="addToNegativePrompt('uncomfortable')">不舒适</el-button>
            <el-button type="primary" round @click="addToNegativePrompt('allergic')">圆冲突金属</el-button>
            <el-button type="info" round @click="addToNegativePrompt('tarnished ')">失去光泽</el-button>
            <el-button type="warning" round @click="addToNegativePrompt('fake')">赝品</el-button>
          </el-row>
        </div>
        <div class="slider-demo-block">
          <label class="form-label">采样迭代次数</label>
          <el-slider v-model="steps" :min="1" :max="50" show-input />
        </div>
        <div class="slider-demo-block">
          <label class="form-label">图像高度</label>
          <el-slider v-model="height" :min="1" :max="1080" show-input />
        </div>
        <div class="slider-demo-block">
          <label class="form-label">图像宽度</label>
          <el-slider v-model="width" :min="1" :max="1080" show-input />
        </div>
        <el-button @click="ImagegenerateImage" :disabled="uploading" type="primary">生成图像</el-button>
        <el-loading v-if="uploading" text="努力生成中..." :background="'rgba(0, 0, 0, 0.7)'"></el-loading>
      </div>
      <div class="col-md-4">
        <div class="container-fluid">
          <img :src="outputImageUrl" alt="Generated Image" class="img-thumbnail">
        </div>
        <div class="row">
          <div class="col-md-4" v-for="(image, index) in images" :key="index">
            <div class="product-item">
              <div class="card text-center">
                <!-- 使用后端返回的图片数据 -->
                <!--            <img :src="'data:image;base64,' + image" class="card-img-top" alt="...">-->
                <img :src="image" class="card-img-top" alt="...">

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import HeaderBar from "@/components/HeaderBar.vue";
import { ElLoading } from 'element-plus';
import axios from "axios";
export default {
  components: {  HeaderBar },

  data() {
    return {
      activeName:'1',
      items: [],
      allData: [],
      selectedFile: null,
      outputImageBase64: '', // Initialize to an empty string
      outputImageUrl:'',
      generatedImage: '',
      file: null,
      originalImageUrl: null,
      uploadedImage: null,
      prediction: "",
      uploading: false,
      steps: 20,
      height: 512,
      width: 512,
      prompt: '',
      negative_prompt: '',
      images: []
    };
  },
  mounted() {
    this.fetchImages();
  },
  methods: {
    addToPrompt(value) {
      if (this.prompt) {
        this.prompt += ', ';
      }
      this.prompt += value;
    },
    addToNegativePrompt(value) {
      if (this.negative_prompt) {
        this.negative_prompt += ', ';
      }
      this.negative_prompt += value;
    },
    handleGeneratedFileUpload(event) {
      this.selectedFile = event.target.files[0];
      this.uploadedImage = URL.createObjectURL(this.selectedFile);
    },
    openFullScreen2() {
      ElLoading.service({
        lock: true,
        text: '努力创作中...',
        background: 'rgba(0, 0, 0, 0.7)',
      });
      // 注意：这里不需要设置关闭时间，会在 uploadImage 方法中手动关闭
      // setTimeout(() => {
      //   loadingInstance.close();
      // }, 2000);
    },
    closeFullScreen2() {
      ElLoading.service().close();
    },
    async generateImages() {
      this.uploading = true; // 开始上传时显示加载动画
      this.openFullScreen2(); // 调用显示全屏加载动画的方法
      let formData = new FormData();
      formData.append('image', this.selectedFile);
      formData.append('steps', this.steps);
      formData.append('height', this.height);
      formData.append('width', this.width);
      formData.append('negative_prompt', this.negative_prompt);
      formData.append('prompt', this.prompt);

      // 发送POST请求以获取生成的图像
      // axios.post('http://127.0.0.1:9200/generate')
      //     .then(response => {
      //       // 设置生成的图像的Base64编码数据
      //       this.generatedImage = response.data.generated_image_base64;
      //     })
      //     .catch(error => {
      //       console.error('Error:', error);
      //     });
      try {
        const response = await axios.post('http://127.0.0.1:9200/generate', formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        }).finally(() => {
          this.closeFullScreen2(); // 接收到数据后关闭加载动画
          this.uploading = false;
        });

        if (response.data && response.data.output_image_url) {
          this.outputImageUrl = response.data.output_image_url;
          this.fetchImages();
        } else {
          alert('Failed to generate image.');
        }
      } catch (error) {
        console.error('Error generating image:', error);
        alert('Error generating image. Please try again later.');
      }
    },
    async ImagegenerateImage() {
      this.uploading = true; // 开始上传时显示加载动画
      this.openFullScreen2(); // 调用显示全屏加载动画的方法
      if (!this.selectedFile) {
        // alert('Please select an image first.');
        await this.generateImages();
        return;
      }

      let formData = new FormData();
      formData.append('image', this.selectedFile);
      formData.append('steps', this.steps);
      formData.append('height', this.height);
      formData.append('width', this.width);
      formData.append('negative_prompt', this.negative_prompt);
      formData.append('prompt', this.prompt);


      try {
        const response = await axios.post('http://127.0.0.1:9200/upload_image', formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        }).finally(() => {
          this.closeFullScreen2(); // 接收到数据后关闭加载动画
          this.uploading = false;
        });

        if (response.data && response.data.output_image_url) {
          console.log(response)
          this.outputImageUrl = response.data.output_image_url;
          console.log(this.outputImageUrl)
          this.fetchImages();
        } else {
          alert('Failed to generate image.');
        }
      } catch (error) {
        console.error('Error generating image:', error);
        alert('Error generating image. Please try again later.');
      }
    },
    //获取生成的图片
    fetchImages() {
      axios.get('http://127.0.0.1:9200/get_images')
          .then(response => {
            this.images = response.data.output_image_urls;
            this.allData = response.data.all_data
            console.log(response);
          })
          .catch(error => {
            console.error('Error fetching images:', error);
          });
    },

  }
};

</script>

<style>
.outer-container {
  border: 2px solid #ddd;
  padding: 20px;
}
.img_container {
  background-color: #f9f9f9;
  border: 1px solid #ddd;
  padding: 0px;
}

.img_container .block {
  background-color: #f9f9f9;
  border: 1px solid #ddd;
  padding: 30px;
  margin: 100px 0;
}
.img_container .block a {
  color: #595b5d;
}

.img_container .block h2 {
  font-weight: 400;
  font-size: 25px;
  text-transform: uppercase;
  margin-top: 40px;
}
.img_container .block form {
  margin-top: 40px;
}

.img_container .block form .btn-main {
  padding: 14px 19px;
}

.img_container .block form p {
  margin-bottom: 20px;
}
.slider-demo-block {
  max-width: 600px;
}


</style>
