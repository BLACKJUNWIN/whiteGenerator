<template>
    <div class="beforeTopHeader_1">
        <div class="beforeTopHeader_1_left">
<#--            <img src="@/assets/logo.svg">-->
        </div>
        <div class="beforeTopHeader_1_right">
            <div v-for="(item,index) in headerTitle" :key="index" @click="$router.push(item.router)" class="beforeTopHeader_1_right_forTitle">
                {{item.name}}
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "beforeTopHeader_1",
        props:{
            headerTitle:{},
        }
    }
</script>

<style scoped>
    .beforeTopHeader_1{
        height: 88px;
        width: 100%;
        display: flex;
        justify-content: space-between;
        line-height: 88px;
        border-bottom: 1px solid rgba(238, 238, 238, 0.9);
    }

    .beforeTopHeader_1_left{
        width: 24%;
        /*background-color: #0084FF;*/
        text-align: center;
    }

    .beforeTopHeader_1_right{
        width: 25%;
        /*background-color: #FF7D00;*/
        display: flex;
        justify-content: space-around;
        margin: 0 2px;
        /*justify-content: right;*/
    }

    .beforeTopHeader_1_right_forTitle{
        color: #333333;
        width: 100%;
        border-right: 1px solid rgba(234, 226, 226, 0.87);
        text-align: center;
        margin: 0 1px;
        font-size: 18px;
        transition: all .4s;
        cursor: pointer;
    }
    .beforeTopHeader_1_right_forTitle:hover{
        background-color: #dba866;
        color: white;
        border-right: 1px solid white;
        text-align: center;
        margin: 0 1px;
    }
</style>