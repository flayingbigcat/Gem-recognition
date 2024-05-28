// import { createRouter, createWebHistory } from 'vue-router'
//
// // 导入组件
// import HelloWorld from '../components/Index.vue'
import SignUp from '../components/SignUp.vue'
import CartPage from '../components/CartPage.vue'
import OrderPage from '../components/OrderPage.vue'
import ShopPage from '../components/ShopPage.vue'
import FeedbackPage from '../components/FeedbackPage.vue'
import EditInfo from '../components/EditInfo.vue'
import ProductPump from '../components/ProductPump.vue'
import PumpSingle from "@/components/PumpSingle.vue";
import ProductSingle from "@/components/ProductSingle.vue";
import TransStyle from "@/components/TransStyle.vue";
import AiCreateImage from "@/components/AiCreateImage.vue";
import UploadProduct from "@/components/UploadProduct.vue";
//
// // 创建路由实例
// const router = createRouter({
//     history: createWebHistory(),
//     routes: [
//         { path: '/', component: HelloWorld },
//         { path: '/Index', component: HelloWorld },
//         { path: '/SignUp', component: SignUp },
//         { path: '/LoginPage', component: LoginPage },
//         { path: '/CartPage', component: CartPage},
//         { path: '/OrderPage', component: OrderPage},
//         { path: '/ShopPage',component: ShopPage},
//         { path: '/ForgetPage',component: ForgetPage},
//         { path: '/TestLogin', component: TestLogin}
//     ],
// });
//
// // 导出路由实例
// export default router;
//createRouter创建router实例对象
//create
import { createRouter,createWebHistory} from 'vue-router'
import login from "../view/loginview.vue";
import HelloWorld from '../components/Index.vue'
import UserPage from  '../components/UserPage.vue'

const routes = [

    {
        path: '/TransStyle',
        component: TransStyle,
    },
    {
        path:'/',
        component: HelloWorld,
    },
    {
        path:'/login',
        component:login,
    },
    {
        path: '/index',
        component: HelloWorld,
    },
    { path: '/SignUp', component: SignUp },
        { path: '/CartPage', component: CartPage},
        { path: '/OrderPage', component: OrderPage},
        { path: '/ShopPage',component: ShopPage},
        { path: '/FeedbackPage', component: FeedbackPage },
    {
        path: '/UserPage', name: 'UserPage', component: UserPage
    },
    {
        path: '/EditInfo',component: EditInfo
    },
    {
        path: '/ProductSingle',component: ProductSingle
    },
    {
      path: '/ProductPump',component: ProductPump
    },
    {
      path: '/PumpSingle',component: PumpSingle
    },
    {
        path: '/ProductSingle/:productId', // 动态片段是 ":productId"
        component: ProductSingle,
        props: true, // 允许通过 props 接收路由参数
        meta: {
            refresh: true // 添加此标记以强制重新加载页面
        }
    },
    {
        path: '/AiCreateImage',
        component: AiCreateImage,
    },
    {path: '/UploadProduct',component: UploadProduct,}

]

const router = createRouter({
    history:createWebHistory(),
    routes
})



export default router;