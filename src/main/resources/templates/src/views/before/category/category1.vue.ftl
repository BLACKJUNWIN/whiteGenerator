<#--主要在于接口,运用会调用分类和商品展示组件-->

<template>
    <div >
        <div style="width:70%;margin: 0 auto;">
            <el-menu active-text-color="#0da1e0" mode="horizontal" style="line-height: 50px;margin-top: 30px;display: flex;justify-content: center">
                <el-menu-item v-for="(item,index) in category" :index="index.toString()" :key="index" @click="getCategoryProperty(item.id)">
                    {{item.categoryName}}
                </el-menu-item>
            </el-menu>

        </div>
        <div style="margin-top: 20px">
            <div style="display: flex;width: 70%;margin: 0 auto" v-if="category.length>0" >
                <div style="display: flex;flex-wrap: wrap;width: 100%;">
                    <div v-for="(item,index) in good" style="width:24%;margin: 10px " :key="index">
                        <div style="text-align: center;cursor: pointer;" @click="$router.push({path:'/home/good_info',query:{id:item.id}})"><img :src="item.imgUrl" style="width: 100%;border-radius: .1em;height: 320px;"></div>
                        <div style="border-bottom: 1px solid #e5e5e5;margin:0 0 10px 0;box-shadow: 0 0 2px #eeeeee;height: 60px;">
                            <div style="text-align: center;padding: 10px 0;height: 20px;line-height: 20px;" class="index_font" @click="$router.push({path:'/home/good_info',query:{id:item.id}})">{{item.goodTitle}}</div>
                            <div style="width: 100%;height: 20px;line-height: 10px;color: #f96868;text-align: center;font-size: 14px;margin-right: 50%;">¥{{item.price}}元</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>

    import {net_category} from "../../../net/before/home";
    import {net_getCategoryProperty} from "../../../net/before/property";
    import boxInfo from "../../../components/common/boxInfo";

    export default {
        name: "category",
        components:{
            boxInfo
        },
        data() {
            return {
                good: [],
                swiper: [],
                category:[],
                activeIndex: 1,
            }
        },
        watch: {
            '$route.query.id': async function (newData, oldData) {
                console.log('hhhh');
                this.active_index=newData;
                await this.getCategoryProperty(newData);
            }
        },
        methods: {
            async getCategoryProperty(id) {
                let res = await net_getCategoryProperty({categoryId: id})
                this.good = res.data;
            }
        },
        async created() {
            console.log('kkkk');
            this.category=(await net_category()).data
            await this.getCategoryProperty(this.$route.query.id);
            // await this.getCategoryProperty(this.category[0].id)
        }
    }
</script>

<style scoped>
    .index_big_img{
        height: 146px;
        display: block;
        transition: all .3s;
        margin: 0 auto;
    }
    .index_big_img:hover{
        transform: scale(1.1);
    }
    .index_font{
        color: #000000;cursor: pointer
    }
    .index_font:hover{
        color: #0da1e0;
    }
    .el-menu{
        border-bottom: none;
        color: black;
    }
    .el-menu--horizontal .el-menu-item:not(.is-disabled):focus, .el-menu--horizontal .el-menu-item:not(.is-disabled):hover{
        background-color:#fff;
        color:#0da1e0 !important;
    }
    .el-menu:hover{
        background-color: white;
    }
    .el-menu--horizontal>.el-menu-item{
        color: black;
        text-align: center;
    }
    .classicInput{
        background-color: rgba(243, 242, 242, 0.7);
        outline: none;
        padding: 14px 30px;
        border-radius: 2em;
        width:520px;
        color: #3b3b3b;
        border: 1px solid rgba(238, 237, 237, 0.6);
    }
</style>
