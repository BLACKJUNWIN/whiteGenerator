<template>
    <div style="width: 100%;" >
        <img src="@/assets/images/indexBg.jpg" style="width: 100%;height: 600px;">
        <div style="width: 70%;margin: 50px auto;">
            <div style="display: flex">
                <div style="width: 30%;height: 300px;">
                    <img :src="goodInfo.imgUrl" style="height:100%;width: 100%">
                </div>
                <div style="width: 50%;">
                    <div style="font-size: 30px;height: 60px;line-height:60px;margin-left: 50px">
                        {{goodInfo.goodTitle}}
                    </div>
                    <div style="font-size: 20px;height: 100px;line-height: 100px;margin-left: 50px;display: flex;background-color: rgba(236,236,236,0.71);margin-top: 20px">
                        <div style="margin-left: 15px;color:  #f96868;">
                            ¥{{goodInfo.price}}
                        </div>
                    </div>
                    <div style="margin-top: 50px">
                        <div style="color: white;line-height: 50px;font-size: 18px;cursor: pointer;margin-left: 50px;background-color: #e12d50;text-align: center;width: 20%;" @click="beforePay()">立即购买</div>
                    </div>
                </div>
            </div>
        </div>
        <div style="width: 70%;margin: 0 auto;font-size: 18px;line-height: 36px">
            {{goodInfo.content}}
        </div>
        <el-dialog
                title="支付接口"
                :visible.sync="payVisible"
                width="40%"
                center>
            <el-form>
                <el-form-item label="钱包余额">
                    <span style="font-weight: bold;color: coral">¥{{ wallet }}</span>
                </el-form-item>
                <el-form-item label="商品价">
                    <span style="font-weight: bold;color: red">-¥{{ goodInfo.price }} x {{number}}</span>
                </el-form-item>
                <el-form-item label="余额">
          <span style="font-weight: bold;color: chocolate">¥{{
              parseFloat(wallet) - (parseFloat(goodInfo.price)*number)
            }}</span>
                    <strong
                            style="margin-left: 30px;color: #f4b023">{{
                        parseFloat(wallet) - (parseFloat(goodInfo.price)*number) >= 0 ? "钱包余额能购买" : "余额不够.请联系管理员充值!"
                        }}</strong>
                </el-form-item>
                <el-form-item>
                    <img :src="this.goodInfo.imgUrl" style="height: 50px"/>
                </el-form-item>
                <div style="display: flex;justify-content: right">
                    <el-button type="info" @click="payVisible=false">取 消</el-button>
                    <el-button type="danger" @click="pay(parseFloat(wallet)-parseFloat(goodInfo.price))"
                               :disabled="parseFloat(wallet) - (parseFloat(goodInfo.price)*number)<0">确 定
                    </el-button>
                </div>
            </el-form>
        </el-dialog>
    </div>

</template>

<script>

    // import {net_selectUser} from "../../../net/back/user";
    import {net_pay} from "../../../net/before/mine";
    import {net_addCollection, net_getCategoryProperty} from "../../../net/before/property";

    export default {
        name: "goodInfo",
        data() {
            return {
                goodInfo: '',
                wallet: 0,
                number:1,
            }
        },
        methods: {
            async beforePay() {
                if (sessionStorage.getItem("id")) {
                    // let res = await net_selectUser({userId: sessionStorage.getItem("id")})
                    // this.wallet = res.data[0].wallet;
                    this.payVisible = true;
                } else {
                    let res = {
                        code: "500",
                        message: "请先登录!"
                    }
                    await this.$router.push("/login");
                    this.$store.commit("tip", res);
                }
            },
            async pay(wallet) {
                let res = await net_pay({userId: sessionStorage.getItem("id"), wallet: wallet,goodId:this.goodInfo.goodId,number:this.number});
                this.$store.commit("tip", res);
                this.payVisible = false;
                await this.$router.push("/home/mine");
            },
            async add_collection() {
                if(sessionStorage.getItem("id")) {
                    let res = await net_addCollection({userId: sessionStorage.getItem("id"), goodId: this.goodInfo.goodId})
                    if (res.code !== "200") {
                        res = {
                            code: "500",
                            message: "请勿重复收藏!"
                        }
                    }
                    this.$store.commit("tip", res);
                }else{
                    let res = {
                        code: "500",
                        message: "请先登录!"
                    }
                    await this.$router.push("/login");
                    this.$store.commit("tip", res);
                }
            },
        },
        async created() {
            let res = await net_getCategoryProperty({id: this.$route.query.id});
            this.goodInfo = res.data[0];
            await this.getEvaluate();
        }
    }
</script>

<style scoped>
    .good_info{
    }
</style>
