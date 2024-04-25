import { createApp } from 'vue'
import App from './App.vue'
import router from '../src/router/index'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap/dist/js/bootstrap.js'
import 'bootstrap/dist/css/bootstrap.min.css'
import ElementPlus from 'element-plus'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import 'element-plus/dist/index.css'
import axios from 'axios'

const app = createApp(App);
app.config.globalProperties.$axios = axios;
createApp(App)
    .use(router)
    .use(ElementPlus)
    .mount('#app');
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
}
// import { createApp } from 'vue'
// import { ElLoading} from 'element-plus'
// import ElementPlus from 'element-plus'
// import 'element-plus/dist/index.css'
// import App from './App.vue'
//
// const app = createApp(App)
//
//
// app.directive('loading',ElLoading.directive)
// app.use(ElementPlus)
// app.mount('#app')