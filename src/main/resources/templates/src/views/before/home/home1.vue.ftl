<template>
    <div style="height: 100%;">
        <div style="width: 100%;margin: 0 auto;display: flex;">
            <div style="width: 100%;height:1000px">
                <img src="@/assets/images/indexBg.jpg" style="width: 100%;height: 100%;">
            </div>
        </div>
        <div style="height: 500px;width: 80%;margin: 0 auto;">
            <div style="margin-top: 40px;text-align:center ">
                <div style="font-size: 28px;color: #181818;"> 商品类别</div>
                <div style="font-size: 14px;;margin: 20px 0 ;color: #808080"> 更容易找到您想要的</div>
            </div>
            <div style="width: 100%;margin: 0 auto;;display: flex;justify-content: space-around">
                <div  style="width: 23%;;cursor: pointer" @click="$router.push({path:'/home/good',query:{id:category[0].id}})">
                    <div>
                        <img src="@/assets/images/index_1.jpg" style="width: 100%">
                    </div>
                    <div style="text-align: center;height: 40px;line-height: 40px" class="index-font">{{category[0].categoryName}}</div>
                </div>
                <div  style="width: 23%;;cursor: pointer" @click="$router.push({path:'/home/good',query:{id:category[1].id}})">
                    <div>
                        <img src="@/assets/images/index_2.jpg" style="width: 100%">
                    </div>
                    <div style="text-align: center;height: 40px;line-height: 40px" class="index-font">{{category[1].categoryName}}</div>
                </div>
                <div  style="width: 23%;;cursor: pointer" @click="$router.push({path:'/home/good',query:{id:category[2].id}})">
                    <div>
                        <img src="@/assets/images/index_3.jpg" style="width: 100%">
                    </div>
                    <div style="text-align: center;height: 40px;line-height: 40px" class="index-font">{{category[2].categoryName}}</div>
                </div>
                <div  style="width: 23%;;cursor: pointer" @click="$router.push({path:'/home/good',query:{id:category[3].id}})">
                    <div>
                        <img src="@/assets/images/index_4.jpg" style="width: 100%">
                    </div>
                    <div style="text-align: center;height: 40px;line-height: 40px" class="index-font">{{category[3].categoryName}}</div>
                </div>
            </div>
        </div>
        <div style="margin-top: 50px;text-align:center ;">
            <div style="font-size: 28px;color: #181818;"> 商品展示</div>
            <div style="font-size: 14px;margin: 20px 0 ;color: #808080"> 我们为您提供的</div>
        </div>
        <div style="display: flex;width: 80%;margin: 0 auto;;justify-content: space-around;flex-wrap: wrap">
            <div v-for="(item,index) in good" style="width:24%;">
                <div style="text-align: center;cursor: pointer;" @click="$router.push({path:'/home/good_info',query:{id:item.id}})"><img :src="item.imgUrl" style="width: 100%;border-radius: .1em;height: 320px;"></div>
                <div style="border-bottom: 1px solid #e5e5e5;margin:0 0 10px 0;box-shadow: 0 0 2px #eeeeee;height: 60px;">
                    <div style="text-align: center;padding: 10px 0;height: 20px;line-height: 20px;" class="index_font" @click="$router.push({path:'/home/good_info',query:{id:item.id}})">{{item.goodTitle}}</div>
                    <div style="width: 100%;height: 20px;line-height: 10px;color: #f96868;text-align: center;font-size: 14px;">¥{{item.price}}元</div>
                </div>
            </div>
        </div>
        <div style="margin-top: 50px;text-align:center;">
            <div style="font-size: 28px;color: #181818;"> 品牌故事</div>
            <div style="font-size: 14px;margin: 20px 0 ;color: #808080"> 让您更全面的了解我们</div>
        </div>
        <div style="width: 80%;margin: 0 auto;">
            <div style="text-indent: 1em;color: #2e333c;line-height: 40px;">
                品牌自诞生以来，就确立了“爱与责任”的核心价值观、“标准、透明、智能”的经营理念，
                专注于家庭装修装饰领域，致力于改变传统行家装不规范，不透明的现状，推动家装行业透明化、标准化发展。
            </div>
            <div style="text-indent: 1em;color: #2e333c;line-height: 40px;">从整装模式到透明家装，再到全品类整装，每一步都走在行业前列。
                为消费者带来“标准化交付、所见即所得”的装修体验，把繁琐的装修过程变得更简单更透明更合理。</div>
            <div></div>
            <div style="text-indent: 1em;color: #2e333c;line-height: 40px;">从整装模式到透明家装，再到全品类整装，每一步都走在行业前列。
                为众多家庭提供整体家装标准化服务，荣获全国住宅装饰装修行业百强企业、具品牌价值家装企业、受市场认可的透明家装品牌、具行业公信力透明家装品牌等众多殊荣。
            </div>
            <div style="text-indent: 1em;color: #2e333c;line-height: 40px;">
                持续致力于为更多消费者打造健康舒适的人居环境，全力以赴推动中国家装的健康发展。
            </div>
        </div>
    </div>
</template>

<script>
    import {net_category} from "../../../net/before/home";
    import boxInfo from "../../../components/common/boxInfo";
    import {net_getGood} from "../../../net/back/goods";

    export default {
        name: "home",
        components:{
            boxInfo
        },
        data() {
            return {
                swiper: '',
                category: '',
                good: '',
                others:'',
            }
        },
        methods: {
            getImage(index) {
                return require('@/assets/images/' + (index + 1) + '.jpg')
            }
        },
        async created() {
            let res2 = await net_category();
            this.category = res2.data.splice(0, 4);
            let result = await net_getGood({});
            this.good = result.data.splice(0,8);
            this.others = result.data.splice(0,4);
            console.log(this.good);
        }
    }
</script>

<style scoped>
    .index-center{
        background: url("~@/assets/images/bj-cloud.png");
    }
    .index-bottem{
        background: url("~@/assets/images/footer-bg.png");
    }
    .index_big_img{
        width: 100%;
        transition: all .3s;
    }
    .index_img{
        width: 80px;
        display: block;
        transition: all .3s;
    }
    .index_img:hover{
        transform: scale(1.1);
    }
    .index_font{
        color: #000000;cursor: pointer;
    }
    .index_font:hover{
        color: #62a8ea;
    }
    .el-input .el-input__inner {
        border: none !important;
        box-shadow: none !important;
    }
    .index-font:hover{
        color: #0da1e0;
    }
</style>
