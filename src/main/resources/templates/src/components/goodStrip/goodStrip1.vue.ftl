<template>
    <div class="listProperty">
        <div class="indexProperty" v-for="(item,index) in propertyList" :key="index">
            <img :src="item.img">
            <div class="propertyInfo">
                <span> {{item.devName}}</span>
            </div>
            <p>{{item.devName}}</p>
        </div>
    </div>
</template>

<script>
    export default {
        name: "listProperty",
        data(){
            return{
                propertyList:[
                    {
                        // img: require('@/assets/testImg.jpg'),
                        devName: "大华球机",
                        devStatus: "未连接",
                    },
                    {
                        // img: require('@/assets/testImg.jpg'),
                        devName: "大华球机",
                        devStatus: "未连接",
                    },
                    {
                        // img: require('@/assets/testImg.jpg'),
                        devName: "大华球机",
                        devStatus: "未连接",
                    },
                    {
                        // img: require('@/assets/testImg.jpg'),
                        devName: "大华球机",
                        devStatus: "未连接",
                    },
                    {
                        // img: require('@/assets/testImg.jpg'),
                        devName: "大华球机",
                        devStatus: "未连接",
                    },
                ],

            }
        }
    }
</script>

<style scoped>
    .listProperty{
        width: 80%;
        display: flex;
        flex-wrap: wrap;
        margin: 0 auto;
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
        margin: 10px ;
        border-radius: 8px;
        cursor: pointer;
        transition: all 1s;
        margin: 20px auto;
    }
    .indexProperty img:hover{
        height: 360px;
        display: block;
        margin: 20px auto;
    }
    .indexProperty img:hover ~.propertyInfo{
        height: 100px;
        display: block;
        margin: 0 auto;
        transition: all 1s;
        position: absolute;
        bottom: 50px;
        left: 17px;
        width: 92%;
        padding: 0 10px;
        opacity: 1;
    }

    .indexProperty p{
        width: 90%;
        margin: 0 auto 10px auto;
        text-align: left;
        color: #0084FF;
        cursor: pointer;
        background-color: #d90606;
    }
    .propertyInfo:hover{
        height: 100px;
        display: block;
        margin: 0 auto;
        transition: all 1s;
        position: absolute;
        bottom: 50px;
        left: 17px;
        padding: 0 10px;
        opacity: 1;
    }
    .propertyInfo {
        position: absolute;
        display: block;
        height: 0px;
        background-color: #ffffff;
        transition: all .5s;
        width: 92%;
        margin: 0 auto;
        bottom: 50px;
        left: 17px;
        opacity: 1;
        padding: 0 10px;
        z-index: 1;
    }
    .propertyInfo span{
        display: none;
    }
</style>