<#--有接口调用,家具网站已用-->

<template>
    <div style="position:relative;min-height: 400px;display: flex;width: 80%;margin: 0 auto;">
        <div style="height: 720px;margin-top: 20px;background-color: #bfddea;width: 100px">
            <div style="">
                <div style="text-align: center;margin-top: 15px;cursor: pointer"  @click="isInfo=1">
                    <i class="el-icon-user" style="font-size: 26px;margin-top: 12px"></i>
                    <div  @click="isInfo=1" style="margin-top: 5px;">基础信息</div>
                </div>
                <div style="text-align: center;margin-top: 30px;cursor: pointer"  @click="isInfo=2;getOrder()">
                    <i class="el-icon-shopping-bag-1" style="font-size: 26px;margin-top: 12px"></i>
                    <div  @click="isInfo=2;getOrder()"  style="margin-top: 5px;">订单</div>
                </div>
                <div style="text-align: center;margin-top: 30px;cursor: pointer"  @click="exit()">
                    <i class="el-icon-circle-close" style="font-size: 26px;margin-top: 12px"></i>
                    <div    style="margin-top: 5px;">退出登录</div>
                </div>
            </div>
        </div>
        <div style="text-align: center;margin:30px 20px 20px 20px;width: 90%;border: 1px solid #ddd;;border-radius: 8px;overflow: scroll">
            <div style="width: 60%;margin: 0 auto;text-align: center;line-height: 40px"  v-if="isInfo===1">
                <div style="text-align: center;margin-top: 80px">
                    <img :src="user.avatar" style="width:180px;border-radius: 50%"/>
                </div>
                <div style="font-size: 24px;color: black;font-weight: bold">{{ user.userName }}</div>
                <div style="text-align: left;width: 100%;margin: 10px auto;font-size: 26px;font-weight: bold;">
                    个人信息
                </div>
                <el-row>
                    <el-col span="4" style="font-size: 18px;font-weight: bold;">
                        用户名
                    </el-col>
                    <el-col span="4" style="color: #8c8a8a">
                        {{ user.userName }}
                    </el-col>
                    <el-col span="4" style="font-size: 18px;font-weight: bold;">
                        手机号
                    </el-col>
                    <el-col span="4" style="color: #8c8a8a">
                        {{ user.phone }}
                    </el-col>
                    <el-col span="4" style="font-size: 18px;font-weight: bold;">
                        钱包
                    </el-col>
                    <el-col span="4" style="color: #8c8a8a">
                        {{ user.wallet }}
                    </el-col>
                </el-row>
                <el-row>
                    <el-col span="4" style="font-size: 18px" >
                        权限
                    </el-col>
                    <el-col span="4" style="color: #8c8a8a">
                        {{ user.role }}
                    </el-col>
                    <el-col span="4" style="font-size: 18px;font-weight: bold;">
                        地址
                    </el-col>
                    <el-col span="4" style="color: #8c8a8a">
                        {{ user.address }}
                    </el-col>
                    <el-col span="4" style="font-size: 18px;font-weight: bold;">
                        操作
                    </el-col>
                    <el-col span="4" style="color: #8c8a8a">
                        <el-button icon="el-icon-edit" type="warning" @click="editVisible=true;updBefore()" title="修改用户信息"/>
                    </el-col>
                </el-row>
            </div>
            <div v-if="isInfo===2" style="">
                <div v-if="order.length>0">
                    <table style="">
                        <tr>
                            <th style="width: 100px">商品名</th>
                            <th>图片</th>
                            <th>价格</th>
                        </tr>
                        <tr v-for="(item,index) in order">
                            <td style="cursor: pointer" @click="$router.push({path:'/home/good_info',query:{id:item.id}})">{{item.goodTitle}}</td>
                            <td><img :src="item.imgUrl" style="width: 120px;cursor:pointer" @click="$router.push({path:'/home/good_info',query:{id:item.goodId}})"></td>
                            <td>{{item.allPrice}}</td>
                        </tr>
                    </table>
                </div>
                <el-empty  v-else description="订单里面啥也没有"/>
            </div>
        </div>
        <el-dialog
                title="修改用户"
                :visible.sync="editVisible"
                width="40%"
                center>
            <el-form>
                <el-form-item label="用户名" required>
                    <el-input v-model="editParam.userName" readonly onfocus="this.removeAttribute('readonly');"></el-input>
                </el-form-item>
                <el-form-item label="密码" required>
                    <el-input v-model="editParam.password" show-password></el-input>
                </el-form-item>
                <el-form-item label="手机号" required>
                    <el-input v-model="editParam.phone" type="number"></el-input>
                </el-form-item>
                <el-form-item label="地址" required>
                    <el-input v-model="editParam.address"></el-input>
                </el-form-item>
                <el-form-item label="头像">
                    <div>&nbsp</div>
                    <div style="display: flex">
                        <div style="margin-right:50px" v-if="editParam.avatar">
                            <img :src="editParam.avatar" alt="头衔" style="height:100px; border-radius: 10%;">
                        </div>
                        <el-upload
                                v-if="!isUpload"
                                class="upload-demo"
                                action="#"
                                :on-change="getFile"
                                multiple
                                :limit="1"
                                :auto-upload="false"
                                style="position:relative;top:10px;text-align: center;">
                            <el-button size="small" type="primary">点击上传</el-button>
                            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
                        </el-upload>
                    </div>
                </el-form-item>
                <el-form-item label="权限" required>
                    <el-select v-model="editParam.role" clearable placeholder="请选择" disabled>
                        <el-option label="管理员" value="admin"/>
                        <el-option label="用户" value="user"/>
                    </el-select>
                </el-form-item>
                <el-form-item label="钱包" required>
                    <el-input v-model="editParam.wallet" type="number" />
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
    <el-button type="info" @click="editVisible=false">取 消</el-button>
    <el-button type="success" @click="updateUser();editVisible=false">确 定</el-button>
  </span>
        </el-dialog>
        <el-dialog
                :title="editTitle"
                :visible.sync="dialogVisible"
                width="40%"
                center>
            <el-form>
                <el-form-item label="商品标题" required>
                    <el-input v-model="goodEditParam.goodTitle"></el-input>
                </el-form-item>
                <el-form-item label="分类" required>
                    <el-select
                            v-model="goodEditParam.categoryId"
                            filterable
                            remote
                            reserve-keyword
                            placeholder="请输入分类名进行筛选"
                            :remote-method="getCategory">
                        <el-option v-for="item in categoryArr" :key="item.index" :label="item.categoryName"
                                   :value="item.categoryIds"/>
                    </el-select>
                </el-form-item>
                <el-form-item label="商品图片">
                    <div>&nbsp</div>
                    <div style="display: flex">
                        <div style="margin-right:50px" v-if="goodEditParam.imgUrl">
                            <img :src="goodEditParam.imgUrl" alt="图片" style="height:100px; border-radius: 10%;">
                        </div>
                        <el-upload
                                v-if="!isUpload"
                                class="upload-demo"
                                action="#"
                                :on-change="getImgFile"
                                multiple
                                :limit="1"
                                :auto-upload="false"
                                style="position:relative;top:10px;text-align: center;">
                            <el-button size="small" type="primary">点击上传</el-button>
                            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
                        </el-upload>
                    </div>
                </el-form-item>
                <el-form-item label="内容" required>
                    <el-input
                            type="textarea"
                            autosize
                            placeholder="请输入内容"
                            v-model="goodEditParam.content">
                    </el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
    <el-button type="info" @click="dialogVisible=false">取 消</el-button>
    <el-button type="success" @click="add(),dialogVisible=false">确 定</el-button>
  </span>
        </el-dialog>
    </div>
</template>

<script>
    import {net_getCollections, net_getOrder, net_info,} from "../../../net/before/mine";
    import largeInfo from "../../../components/common/largeInfo";
    // import {net_selectUser, net_updateUser} from "../../../net/back/user";
    import {uploadFile} from "../../../net/back/file";
    import {net_getCategory} from "../../../net/back/category";
    import {net_insertGood} from "../../../net/back/goods";

    export default {
        name: "mine",
        components: {
            largeInfo
        },
        data() {
            return {
                user: '',
                isInfo: 1,
                collection: '',
                order: [],
                editVisible: false,
                dialogVisible:false,
                isUpload: false,
                editParam: {
                    role: '',
                    userName: '',
                    phone: '',
                    address: '',
                    password: '',
                    avatar: '',
                },
                goodEditParam: {
                    goodTitle: '',
                    imgUrl: '',
                    categoryId: '',
                    content: '',
                },
                editTitle: '用户分享',
                categoryArr:[],
            }
        },
        methods: {
            async getOrder(){
                console.log(this.user.id);
                this.order=(await net_getOrder({id:2})).data;
            },
            async getCollection() {
                let res = await net_getCollections({userId: sessionStorage.getItem("id")});
                this.collection = res.data;
            },
            async getCategory() {
                let res = await net_getCategory({});
                this.categoryArr = res.data;
            },
            exit() {
                sessionStorage.clear();
                this.$router.push("/login")
                let res = {
                    code: "200",
                    data: "登出成功!"
                }
                this.$store.commit("tip", res);
            },
            filterRequest(values) {
                let newValues = values;
                Object.keys(newValues).map((item) => {
                    if (!newValues[item]) {
                        delete newValues[item];
                    }
                    return true;
                });
                return newValues;
            },
            beforeAdd() {
                this.dialogVisible=true;
                // this.goodEditParam='';
            },
            async add() {
                let res=(await net_insertGood(this.goodEditParam));
                if(res.code==="200"){
                    this.dialogVisible=false;
                    this.dialogVisible=[];
                }
                this.$store.commit("tip",res);
                this.dialogVisible=false;
            },
            async getFile(file) {
                let data = new FormData();
                data.append("file", file.raw);
                data.append("category", "avatar");
                data.append("md5", "1");
                let res = (await uploadFile(data)).data;
                if (res.code === "200") {
                    this.editParam.avatar = res.data.path;
                    this.isUpload = true;
                }
                this.$store.commit("tip", res);
            },
            async getImgFile(file){
                let data = new FormData();
                data.append("file", file.raw);
                data.append("category", "avatar");
                data.append("md5", "1");
                let res = (await uploadFile(data)).data;
                if (res.code === "200") {
                    this.goodEditParam.imgUrl = res.data.path;
                    this.isUpload = true;
                }
                this.$store.commit("tip", res);
            },
            verify() {
                let res = {
                    code: "500",
                    message: ""
                };
                if (this.editParam.userName === "") {
                    res.message = "用户名字未填写";
                } else if (this.editParam.password === "") {
                    res.message = "用户密码未填写";
                } else if (this.editParam.role === "") {
                    res.message = "用户权限没有填写"
                }
                if (res.message !== "") {
                    this.$store.commit("tip", res);
                    return false;
                } else {
                    return true;
                }
            },
            async updBefore() {
                this.editParam = (await net_selectUser({user_id: sessionStorage.getItem("id")})).data[0];
                this.editTitle = this.$route.name + "(修改)";
            },
            async updateUser() {
                // let res2 = await net_updateUser(this.editParam);
                // this.$store.commit("tip", res2);
                this.isUpload = true;
                let res = await net_info({user_id: sessionStorage.getItem("id")});
                this.user = res.data[0];
            },
        },
        async created() {
            let res = await net_info({id: sessionStorage.getItem("id")});
            this.user = res.data[0];
            await this.getCategory();
            await this.getOrder();
            sessionStorage.setItem("user", this.user.userName);
        }
    }
</script>

<style scoped>
    table { border-collapse: collapse;width: 100%;}
    table,table tr th, table tr td {
        border:1px solid #dddddd;
        margin: 5px 0;
        text-align: center;
    }
    table
    {
        border-collapse: collapse;
        margin: 0 auto;
        text-align: center;
    }
    table th
    {
        background-color: #ffffff;
        /*font-weight: bold;*/
    }
    table td, table th
    {
        color: #3f3e3e;
        height:40px;
    }
    table thead th
    {
        /*background-color: #5ab6c0;*/
        width: 100px;
    }

</style>
