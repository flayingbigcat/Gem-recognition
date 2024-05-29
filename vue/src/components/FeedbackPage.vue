<template>
  <header-bar></header-bar>
  <div class="container-fluid">
    <div class="row">
      <div class="col text-center" style="padding: 30px">
        <h2>宝石识别</h2>
      </div>
    </div>
    <div class="row justify-content-center" style="padding: 20px">
      <div class="col-md-2 ">
        <el-upload
            class="avatar-uploader"
            action="http://127.0.0.1:9200/upload_test"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload"
            :disabled="uploading">
          <img v-if="imageUrl" :src="imageUrl" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon">上传图片</i>
        </el-upload>
        <el-loading v-if="uploading" text="努力生成中..." :background="'rgba(0, 0, 0, 0.7)'"></el-loading>
      </div>
      <div class="col-md-5">
        <h>识别结果: {{ prediction }}</h>
        <p>{{ gem_content }}</p>
      </div>
    </div>
    <div class="row justify-content-center">
      <div class="col-md-6">
        <label>历史记录</label>
        <el-collapse v-model="activeName" accordion>
          <template v-for="item in allData" :key="item.name">
            <el-collapse-item :title="item[4]" :name="item.name">
              <div>
                <div class="demo-image__placeholder">
                  <div class="end-0">
                    <el-button @click="deleteRecord(item[0], item[4], item[2])" type="info">删除记录</el-button>
                  </div>
                  <div class="block">
                    <span class="demonstration">
                      <p>宝石名称: {{ item[3] }}</p>
                    </span>
                    <el-image :src="item[2]">
                    </el-image>
                  </div>
                </div>
                <p>{{ item[1] }}</p>

              </div>
            </el-collapse-item>
          </template>
        </el-collapse>
      </div>
    </div>
  </div>

</template>

<script>
import { ElLoading } from 'element-plus';
import axios from 'axios';
import HeaderBar from "@/components/HeaderBar.vue";

export default {
  components: { HeaderBar },
  data() {
    return {
      user_id:localStorage.getItem('user_id'),
      allData: [],
      activeName:'1',
      imageUrl: '',
      selectedFile: null,
      file: null,
      prediction: "",
      uploading: false,
      images: [],
      gem_content:''
    };
  },
  created() {
    this.fetchImages();
  },
  methods: {
    deleteRecord(userId, createTime, imgUrl) {
      axios.post('http://127.0.0.1:9200/delete_rec_record', {
        user_id: userId,
        create_img_time: createTime,
        img_url: imgUrl  // 将文件路径传递给后端
      })
          .then(response => {
            if (response.data.success) {
              // 从allData中删除记录
              this.allData = this.allData.filter(item => !(item[0] === userId && item[4] === createTime));
              this.$message.success('记录删除成功');

              // 删除文件
            } else {
              this.$message.error('删除失败: ' + (response.data.error || '未知错误'));
            }
          })
          .catch(error => {
            console.error('Error deleting record:', error);
            this.$message.error('删除失败: ' + (error.response?.data?.error || '服务器错误'));
          });
    },
    handleAvatarSuccess(res, file) {
      this.imageUrl = URL.createObjectURL(file.raw);
      this.uploading = true; // 开始上传时显示加载动画
      this.openFullScreen2(); // 调用显示全屏加载动画的方法

      let formData = new FormData();
      formData.append("image", file.raw);
      formData.append("user_id", this.user_id); // 将 user_id 添加到 FormData 中
      console.log(this.imageUrl)

      axios
          .post("http://127.0.0.1:9200/predict", formData)
          .then(response => {
            console.log(response.data);
            this.prediction = response.data.gem_name;
            this.gem_content = response.data.gem_content;
            this.fetchImages()
          })
          .catch(error => {
            console.error("上传图片时出错: ", error);
          })
          .finally(() => {
            this.closeFullScreen2(); // 接收到数据后关闭加载动画
            this.uploading = false;
          })
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    },
    openFullScreen2() {
       ElLoading.service({
        lock: true,
        text: '识别中...',
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
    fetchImages() {
      axios.get('http://127.0.0.1:9200/get_history', {
        params: {
          user_id: this.user_id // 将 user_id 作为查询参数传递给后端
        }
      }).then(response => {
        console.log(response)
        this.allData = response.data.all_data
      }).catch(error => {
        console.error('Error fetching images:', error);
      });
    },
  }
};
</script>
<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>










