// import axios from 'axios';
//
// // 创建一个 Axios 实例
// const instance = axios.create({
//     baseURL: '', // 设置请求的基础 URL
//     timeout: 5000, // 设置请求超时时间
// });
//
// // 在请求发送之前的拦截器中设置 Token
// instance.interceptors.request.use(config => {
//     // const token = sessionStorage.getItem('tokenValue'); // 从 sessionStorage 中获取 Token
//     // if (token) {
//     //     config.headers.Authorization = token; // 设置请求头中的 Authorization 字段为 Token
//     // }
//     return config;
// });
// export default instance

import axios from 'axios';

// 创建一个 Axios 实例
const instance = axios.create({
    baseURL: '', // 设置请求的基础 URL
    timeout: 5000, // 设置请求超时时间
});
export default instance