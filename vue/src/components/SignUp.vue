<template>
    <div class="account">
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="block text-center">
                        <h2 class="text-center">SIGN</h2>
                        <form>
                            <div class="mb-3">
                                <input type="email" class="form-control" id="userNameInput" v-model="form.user_name" placeholder="NAME">
                            </div>
                            <div class="mb-3">
                                <input type="email" class="form-control" id="userEmailInput" v-model="form.user_email" placeholder="EMAIL">
                            </div>
                            <div class="mb-3">
                                <input type="password" class="form-control" id="passwordInput" v-model="form.user_password" placeholder="PASSWORD">
                            </div>
                            <div class="mb-3">
                                <button type="button" class="btn btn-dark text-center" @click="register">Sign</button>
                                <!--                                <button type="button" class="btn btn-secondary" @click="register">注册</button>-->
                            </div>
                        </form>
                        <p class="mt-20">Already hava an account ?<router-link to="/login"> Login</router-link></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</template>

<script>
import axios from 'axios';
// import { useRouter } from 'vue-router';
import { ElMessage } from 'element-plus'
// import {ref} from 'vue';

export default {
    name: 'SignUp',
    data() {
        return {
            form: {
                user_id:'',
                user_name: '',
                user_email: '',
                user_password: ''
            }
        };
    },
    methods: {
        async register() {
            // 前端验证
            if (!this.form.user_name.trim()) {
                ElMessage.error('用户名不能为空');
                return;
            }
            if (!this.form.user_email.match(/^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/)) {
                ElMessage.error('请输入有效的电子邮箱地址');
                return;
            }
            if (!this.form.user_password || this.form.user_password.length < 6) {
                ElMessage.error('密码不能为空且长度至少为6个字符');
                return;
            }
            // 'User registered successfully'
            try {
                const response = await axios.post('http://127.0.0.1:9200/SignUp', this.form);
                // 处理成功或根据需要重定向到新页面
                console.log(response.data);
                if (response.data !== null) {
                    // 可选地，可以使用Vue Router在成功注册后导航到另一个页面
                    this.user_id=response.data.user_id;
                    localStorage.setItem('user_id',this.user_id);
                    localStorage.setItem('user_email', this.form.user_email);
                    localStorage.setItem('user_name', this.form.user_name);
                    console.log('user_id',this.user_id)
                    this.$router.push('/UserPage');
                }
            } catch (error) {
                console.error(error);
                // 处理注册错误，显示消息或重定向到错误页面
                ElMessage.error('注册失败，请重试。');
            }
        },
    }
};
</script>