<template>
    <div class="account">
        <div class="container" >
            <div class="row">
                <div class="col-md-6 offset-md-3">
                  <div class="block">
                    <div class="row justify-content-center">

                        <el-image :src="src" style="width: 150px;height: 100px">
                        </el-image>
                      <div class="text-center">
                        <h2>基于大模型的宝石识别与设计平台</h2>
                      </div>

                    </div>
                    <div class="block text-center">
                      <form>
                        <div class="mb-3">
                          <input type="email" class="form-control" id="userNameInput" v-model="form.user_email" placeholder="邮箱">
                        </div>
                        <div class="mb-3">
                          <input type="password" class="form-control" id="passwordInput" v-model="form.user_password" placeholder="密码">
                        </div>
                        <div class="mb-3">
                          <button type="button" class="btn btn-dark justify-content-center" @click="login">登录</button>
                          <!--                                <button type="button" class="btn btn-secondary" @click="register">注册</button>-->
                        </div>
                      </form>
                      <p class="mt-20">还没账号 ?<a @click="register"> 注册</a></p>
                    </div>

                  </div>
<!--                    <div class="block text-center">-->
<!--                        <h2 class="text-center">登录</h2>-->
<!--                      <div class="demo-image__placeholder">-->
<!--                        <div class="block">-->
<!--                          <span class="demonstration"> <h2 class="text-center">登录</h2></span>-->
<!--                          <el-image :src="src">-->
<!--                          </el-image>-->
<!--                        </div>-->
<!--                      </div>-->
<!--                        <form>-->
<!--                            <div class="mb-3">-->
<!--                                <input type="email" class="form-control" id="userNameInput" v-model="form.user_email" placeholder="邮箱">-->
<!--                            </div>-->
<!--                            <div class="mb-3">-->
<!--                                <input type="password" class="form-control" id="passwordInput" v-model="form.user_password" placeholder="密码">-->
<!--                            </div>-->
<!--                            <div class="mb-3">-->
<!--                                <button type="button" class="btn btn-dark text-center" @click="login">登录</button>-->
<!--&lt;!&ndash;                                <button type="button" class="btn btn-secondary" @click="register">注册</button>&ndash;&gt;-->
<!--                            </div>-->
<!--                        </form>-->
<!--                        <p class="mt-20">还没账号 ?<a @click="register"> 注册</a></p>-->
<!--                    </div>-->
                </div>
            </div>
        </div>
    </div>

</template>

<script>
import axios from 'axios';
import { useRouter } from 'vue-router';
import { ElMessage } from 'element-plus'
import {ref} from 'vue';

export default {
  data() {
    return {
      src: 'http://127.0.0.1:9200/IMG/Gem_img/background_11.jpg'
    }
  },
  name: 'LoginView',
  setup() {
    const form = ref({
      user_email: '',
      user_password: '',
    });
    const router = useRouter();
    const user_id = ref(null); // 创建一个响应式变量用于存储 user_id

    const login = () => {
      axios.post('http://127.0.0.1:9200/login', JSON.stringify(form.value), {
        headers: {
          'Content-Type': 'application/json',
        }
      })
          .then(response => {
            // 登录成功
            console.log(response.data); // 这里的 response.data 包含了用户信息
            const responseData = response.data;
            if (responseData.status === 'success') {
              const userId = responseData.user_id;
               // 将 user_id 存储在本地存储中
              localStorage.setItem('user_id', userId)
              console.log(userId)
              user_id.value = userId; // 将 user_id 存储在响应式变量中
              router.push('/index');
            } else {
              failed();
            }
          })
          .catch(error => {
            if (error.response && error.response.status === 401) {
              failed();
            } else {
              ElMessage.error('登录失败');
            }
          });
    };

    const failed = () => {
      ElMessage.error('用户名或密码错误');
    };

    const register = () => {
      router.push('/SignUp');
    };

    return {
      login,
      register,
      form,
      user_id, // 将 user_id 暴露给模板
    };
  },
};
</script>

<style scoped>
.login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f5f5f5;
}

.login-form {
    width: 400px;
    padding: 20px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
}

.title {
    text-align: center;
    margin-bottom: 20px;
}
@import "../css/_log.css";
</style>