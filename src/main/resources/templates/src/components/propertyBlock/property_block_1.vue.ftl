<template>
    <div class="propertyBlock">
        <div v-for="(item,index) in property" :key="index" class="property_block_1_for">
            <img :src="item.img" class="property_block_1_img">
            <div class="property_block_1_title">
                {{item.title}}
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "property_block_1",
        props:{
            property:{},
        }
    }
</script>

<style scoped>
    .propertyBlock{
        width: 80%;
        margin: 0 auto;
        display: flex;
        flex-wrap: wrap;
        cursor: pointer;
    }
    .property_block_1_for{
        width: 23%;margin: 5px;height: 220px;
        border: 1px solid #ffffff;
        transition: all .3s;
    }
    .property_block_1_for:hover{
        /*border: 1px solid #dddddd;*/
        margin-bottom: 4px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        border-radius: 8px;
        /*box-shadow: ;*/
    }
    .property_block_1_img{
        width: 99%;text-align: center;height: 180px;
        border-radius: 8px;
    }
    .property_block_1_title{
        text-align: center;
        color: #1D2129;
        font-size: 16px;
        line-height: 40px;
    }
    .property_block_1_title:hover{
        text-align: center;
        color: #dba866;
        font-size: 16px;
        line-height: 40px;
    }
</style>