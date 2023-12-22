<template>
    <div class="propertyClassicModel_1">
        <div class="propertyClassicModel_1_title">产品系列</div>
        <div class="propertyClassicModel_1_for_block">
            <div class="propertyClassicModel_1_for" v-for="(item,index) in category" :key="index">
                {{item.title}}
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "propertyClassic1",
        props:{
            category:{},
        }
    }
</script>

<style scoped>
    .propertyClassicModel_1{
        height: 125px;
        text-align: center;
        border-bottom: 2px solid #dba866;
    }

    .propertyClassicModel_1_title{
        font-size: 20px;
        height: 60px;
        line-height: 60px;
        color: #333333;
    }

    .propertyClassicModel_1_for_block{
        display: flex;
        justify-content: center;
    }

    .propertyClassicModel_1_for{
        width: 80px;
        height: 40px;
        line-height: 40px;
        margin: 0 8px;
        background: #f8f8f8;
        color: #333333;
        border-radius: 2px;
        transition: all .1s;
        cursor: pointer;
    }

    .propertyClassicModel_1_for:hover{
        width: 80px;
        height: 40px;
        line-height: 40px;
        background: #dba866;
        color: white;
    }
</style>
