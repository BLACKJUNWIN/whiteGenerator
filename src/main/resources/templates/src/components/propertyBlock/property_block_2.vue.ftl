<template>
    <div class="listProperty">
        <div class="indexProperty" v-for="(item,index) in goodList" :key="index" @click="$router.push({path:'/home/good_info',query:{id:item.id}})">
            <img :src="item.imgUrl">
            <div class="propertyInfo">
                {{item.content.substring(0,75)}}
            </div>
            <p>{{item.goodTitle}}</p>
        </div>
    </div>
</template>

<script>
    export default {
        name: "property_block_2",
        props:{
            goodList:{},
            // eslint-disable-next-line vue/require-prop-type-constructor
            good: '',
        },
        data(){
            return{
            }
        }
    }
</script>

<style scoped>
    .listProperty{
        width: 80%;
        display: flex;
        flex-wrap: wrap;
        margin: 10px auto;
    }
    .indexProperty {
        width: 23.5%;
        margin: 8px 10px;
        border: 1px solid #e0e0e0;
        text-align: center;
        border-radius: 8px;
        position: relative;
    }
    .indexProperty img{
        width: 90%;
        height: 360px;
        z-index: 1;
        border-radius: 8px;
        cursor: pointer;
        transition: all 1s;
        margin: 20px auto;
    }
    .indexProperty img:hover{
        width: 90%;
        height: 360px;
        border-radius: 8px;
        cursor: pointer;
        transition: all 1s;
        margin: 20px auto;
    }
    .indexProperty p{
        width: 90%;
        margin: 0 auto 10px auto;
        text-align: left;
        color: #0084FF;
        cursor: pointer;
        z-index: 20;
        position: relative;
    }
    .indexProperty img:hover ~.propertyInfo{
        height: 110px;
        display: block;
        margin: 0 auto;
        transition: all .4s;
        position: absolute;
        bottom: 50px;
        padding: 5px 17px;
        opacity: 1;
        z-index: 5;
        line-height: 24px;
        color: #6b6a6a;
        visibility: visible;
    }
    .propertyInfo:hover{
        height: 110px;
        display: block;
        margin: 0 auto;
        transition: all .4s;
        position: absolute;
        bottom: 50px;
        line-height: 24px;
        padding:5px 17px;
        opacity: 1;
        z-index: 5;
        visibility: visible;
        color: #0da1e0;
    }
    .propertyInfo {
        position: absolute;
        display: block;
        height: 2px;
        background-color: #ffffff;
        transition: all .4s;
        width: 90%;
        line-height: 24px;
        margin: 0 auto;
        bottom: 50px;
        /*left: 5px;*/
        opacity: 1;
        padding: 5px 17px;
        z-index: 5;
        visibility: hidden;
        overflow: hidden;
        color: #afaeae;
    }
</style>
