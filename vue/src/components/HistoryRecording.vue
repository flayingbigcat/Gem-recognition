<template>
  <header-bar></header-bar>
    <div>
        <el-container style="height: 700px; border: 1px solid #eee">
            <!-- 顶栏 -->
<!--            <el-header style="background-color: rgb(238, 241, 246); font-size: 45px">-->
<!--                宝石识别历史记录-->
<!--            </el-header>-->

            <el-container>
                <!-- 侧边栏 -->
                <el-aside width="220px" style="border: 1px solid #eee">
                    <el-menu :default-openeds="['1', '3']">
                        <el-submenu index="1">
                            <template><i class="el-icon-message"></i>浏览记录管理</template>

                            <el-menu-item-group>
                                <el-menu-item index="1-1">
                                    <router-link to="/dept">原始图片图片</router-link>
                                </el-menu-item>
                                <el-menu-item index="1-2">
                                    <router-link to="/emp">查询图片管理</router-link>
                                </el-menu-item>
                            </el-menu-item-group>
                        </el-submenu>
                    </el-menu>
                </el-aside>

                <!-- 主区域 -->
                <el-main>
                    <!-- 搜索栏 -->
                    <el-form :inline="true" :model="searchForm" class="demo-form-inline">
                        <el-form-item label="查询图片名称">
                            <el-input v-model="searchForm.name" placeholder="请出入查询图片名称"></el-input>
                        </el-form-item>


                        <el-form-item label="时间">
                            <el-date-picker v-model="searchForm.entrydate" type="daterange" range-separator="至"
                                start-placeholder="开始日期" end-placeholder="结束日期">
                            </el-date-picker>
                        </el-form-item>

                        <el-form-item>
                            <el-button type="primary" @click="onSubmit">查询</el-button>
                        </el-form-item>
                    </el-form>

                    <br />

                    <!-- 表格 -->
                    <el-table :data="tableData" border style="width: 100%">
                        <el-table-column prop="name" label="名称" width="180"></el-table-column>

                        <el-table-column label="图像" width="180">


                        </el-table-column>
                        <el-table-column prop="entrydate" label="查询时间" width="180"></el-table-column>
                        <el-table-column prop="updatetime" label="最后操作时间" width="230"></el-table-column>
                        <el-table-column label="操作">
                            <el-button type="primary" size="mini">编辑</el-button>
                            <el-button type="danger" size="mini">删除</el-button>
                        </el-table-column>

                    </el-table>

                    <br>

                    <!-- 分页 -->
                    <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                        :current-page="currentPage4" :page-sizes="[10, 20, 30, 40]" :page-size="10"
                        layout="sizes, total , prev, pager, next, jumper" :total="400">
                    </el-pagination>

                </el-main>
            </el-container>
        </el-container>
    </div>
</template>

<style></style>

<script>
import axios from 'axios'
import HeaderBar from "@/components/HeaderBar.vue";

export default {
  components: {HeaderBar},
    data() {
        return {
            tableData: [],
            searchForm: {
                name: "",
                gender: "",
                entrydate: "",
            },
        };
    },
    methods: {
        handleSizeChange(val) {
            console.log(`每页 ${val} 条`);
        },
        handleCurrentChange(val) {
            console.log(`当前页: ${val}`);
        }
    },
    mounted() {
        //发送异步请求
        axios.get("http://yapi.smart-xwork.cn/mock/169327/emp/list").then((result) => {
            this.tableData = result.data.data;
        });
    }
};
</script>