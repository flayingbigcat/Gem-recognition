<template>
    <div>
        <header-bar></header-bar>
    </div>
    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="content">
                        <h1 class="page-name">Order</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><router-link style="text-decoration: none" to="/">Home</router-link></li>
                                <li class="breadcrumb-item active" aria-current="page">Order</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="dashboard-Cart">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Items</th>
                    <th scope="col">Total Price</th>
                </tr>
                </thead>
                <tbody class="table-group-divider">
                <tr v-for="(item, index) in tableData" :key="index">
                    <th scope="row">{{ index + 1 }}</th>
                    <td>{{ item.date }}</td>
                    <td v-if="item.items !== undefined">{{ item.items }}</td>
                    <td v-else colspan="2">{{ item.price }}</td>
                    <td>{{ item.price }}</td>
                    <td><button btn-bt-dark @click="deleteRow(index)">Delete</button></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <footer-bar></footer-bar>
</template>
<script>
import HeaderBar from "@/components/HeaderBar.vue";
import {defineComponent} from "vue";
import FooterBar from "@/components/FooterPage.vue";

export default defineComponent({
    components: {FooterBar, HeaderBar},
    data() {
        return {
            tableData: [
                { date: 'Mar 25, 2023', items: '1', price: '9999$' },
                { date: 'Mar 25, 2023', items: '1', price: '9999$' },
                { date: 'Mar 25, 2023', items: '1', price: '9999$' },
            ]
        };
    },
    methods: {
        // 删除行的方法
        deleteRow(index) {
            this.tableData.splice(index, 1);
        }
    }
})

</script>
<style>
@import "../css/_common.css";
</style>