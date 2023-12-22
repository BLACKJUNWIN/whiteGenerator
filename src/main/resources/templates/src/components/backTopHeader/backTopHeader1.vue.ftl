<template>
    <div class="backTopHeader">
        <div  class="back-top-left"><img :src="imgPath"></div>
        <div  class="back-top-center">
            <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal">
                <el-menu-item :index="item.index" v-for="(item,index) in titleLine" @click="$router.push(item.router)" :key="index">{{item.title}}</el-menu-item>
            </el-menu>
        </div>
        <div  class="back-top-right">
            <slot name="userInfo"></slot>
        </div>
    </div>
</template>

<script>
    export default {
        name: "backTopHeader",
        props:{
            imgPath:String,
            titleLine:[],
        },
        data(){
            return{
                activeIndex:'0'
            }
        }
    }
</script>

<style scoped>

</style>