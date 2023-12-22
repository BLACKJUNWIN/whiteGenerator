<template>
    <div class="classicColumn">
        <div class="allClassic">
            所有分类:
        </div>
        <div class="classicAll">
            全部
        </div>
        <div v-for="(item,index) in classic" :key="index" class="classicName">
            {{item.classicName}}
        </div>
    </div>
</template>

<script>
    export default {
        name: "propertyClassic2",
        data(){
            return{
                classic:[
                    {
                        classicName:'家具洗护'
                    },
                    {
                        classicName:'家具洗护'
                    },
                    {
                        classicName:'家具洗护'
                    },
                    {
                        classicName:'家具洗护'
                    },
                ]
            }
        }
    }
</script>

<style scoped>
    .classicColumn{
        height: 36px;
        border: 1px solid #d3d3d3;
        width: 80%;
        margin: 10px auto;
        border-radius: 3px;
        display: flex;
        background-color: rgba(241, 241, 241, 0.6);
    }

    .allClassic{
        width: 100px;background-color: #cbcbcb;text-align: center;line-height: 36px;font-size: 16px;color: #383737
    }

    .classicAll{
        width: 80px;text-align: center;line-height: 34px;color: #c9924c;cursor: pointer
    }

    .classicName{
        text-align: center;
        width: 6%;
        line-height: 34px;
        cursor: pointer;
        background-color: rgba(241, 241, 241, 0.6);
    }
    .classicName:hover{
        color: #c9924c;
    }
</style>
