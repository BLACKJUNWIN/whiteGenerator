<#--有接口的调用,家具网站已用-->

<template>
    <div>
        <div style="width:100%;overflow: hidden;background-color: #466dec;" :style="fullHeight">
            <div class="submit" :style="loginStyle" v-if="isLogin" style="  height: 350px;left: -36%;background-color: #ac94ff;width: 600px">
                <div style="display: flex;">
                    <div style="text-align: center;background-color: white;width: 60%;margin-top: -45px;margin-left: 10px;padding: 20px 0;" >
                        <img src="@/assets/images/flight.svg" alt="头像" style="width:100px;margin-bottom:8px;">
                        <div>
                            <el-form ref="form" label-position='top'>
                                <el-form-item>
                                    <div style="font-size: 16px;font-weight: bold">用户名</div>
                                    <el-input style="width:320px" v-model="user.userName"></el-input>
                                </el-form-item>
                                <el-form-item>
                                    <div style="font-size: 16px;font-weight: bold">密码</div>
                                    <el-input style="width:320px" show-password v-model="user.password"></el-input>
                                </el-form-item>
                                <el-form-item>
                                    <el-radio v-model="role" label="user"><strong>用户</strong></el-radio>
                                    <el-radio v-model="role" label="admin"><strong>管理员</strong></el-radio>
                                </el-form-item>
                            </el-form>
                            <div style="text-align: center;position:relative;">
                                <el-button  @click="login()" style="background-color: #5fa1f8;color: white;height: 50px;width: 100px;">登录</el-button>
                            </div>
                        </div>
                    </div>
                    <el-button style="height: 50px;width: 100px;position: relative;margin-top: 150px;border: 1px solid #fff;background-color:#ac94ff;color: white;margin-left: 60px " @click="isLogin=false">注册</el-button>
                </div>

            </div>
            <div class="submit" :style="loginStyle" v-else style="  height: 350px;text-align: center;left: 36%;background-color: #ac94ff;width: 600px;padding: 10px 0;">
                <div style="display: flex">
                    <div style="background-color: white;text-align: center;width: 60%;margin-top: -55px;margin-left: 20px;padding: 20px 0;">
                        <div style="margin-top: 10px;">
                            <img src="@/assets/images/flight.svg" alt="头像" style="width:100px;margin-bottom:8px;">
                        </div>
                        <el-form ref="form" label-position='top'>
                            <el-form-item>
                                <div style="font-size: 16px;font-weight: bold">用户名</div>
                                <el-input style="width:320px" v-model="registers.userName"></el-input>
                            </el-form-item>
                            <el-form-item>
                                <div style="font-size: 16px;font-weight: bold">密码</div>
                                <el-input style="width:320px" show-password v-model="registers.password1"></el-input>
                            </el-form-item>
                            <el-form-item>
                                <div style="font-size: 16px;font-weight: bold">重新输入密码</div>
                                <el-input style="width:320px" show-password v-model="registers.password2"></el-input>
                            </el-form-item>
                        </el-form>
                        <div style="text-align: center;">
                            <el-button type="success" style="height: 50px;width: 100px;position: relative;border: 1px solid #fff;background-color:#5fa1f8;color: white;" @click="registerUser()">注册</el-button>
                        </div>
                    </div>
                    <el-button @click="isLogin=true" style="height: 50px;width: 100px;position: relative;border: 1px solid #fff;background-color:#ac94ff;color: white;margin-left: 60px ;margin-top: 150px">登录</el-button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import {net_login, net_register} from "../net/before/mine";

    export default {
        name: "login",
        data() {
            return {
                fullHeight: '',
                isLogin: true,
                role:"user",
                user: {
                    userName: '',
                    password: ''
                },
                loginStyle: '',
                registers: {
                    userName: '',
                    password1: '',
                    password2: ''
                }
            }
        },
        methods: {
            //用户登录
            async login() {
                let res = {
                    code: "500",
                    message: ""
                }
                if (this.user.userName === '') {
                    res.message = "用户名为空"
                } else if (this.user.password === '') {
                    res.message = "密码为空"
                }
                if(res.message===""){
                    let uploadUser = {
                        userName: this.user.userName,
                        password: this.user.password
                    }
                    let res = await net_login(uploadUser);
                    console.log(res.data);
                    if (res.code === "200") {
                        if (this.role === "admin") {
                            if (res.data.role !== "admin") {
                                res = {
                                    code: "500",
                                    message: "用户权限不够!"
                                }
                            } else {
                                sessionStorage.setItem("id", res.data.id);
                                sessionStorage.setItem("user", res.data.userName);
                                await this.$router.push("/back_home/user");
                            }
                        } else {
                            sessionStorage.setItem("id", res.data.id);
                            await this.$router.push("/home/mine");
                        }
                    }
                    this.$store.commit("tip", res);
                    this.user = {
                        userName: '',
                        password: ''
                    }
                    this.role="user";
                }else{
                    this.$store.commit("tip", res);
                }
            },
            //用户注册
            async registerUser() {
                let res = {
                    code: "500",
                    message: ""
                }
                if (this.registers.userName === '') {
                    res.message = "用户名为空"
                } else if (this.registers.password1 === '') {
                    res.message = "密码为空"
                } else if (this.registers.password1 !== this.registers.password2) {
                    res.message = "密码不一致"
                }
                if (res.message === '') {
                    let uploadUser = {
                        userName: this.registers.userName,
                        password:this.registers.password1,
                        role: "user",
                    }
                    let res = await net_register(uploadUser);
                    if(res.code==="200"){
                        this.isLogin=true;
                    }
                    this.$store.commit("tip", res);
                    this.registers = {
                        userName: '',
                        password1: '',
                        password2: ''
                    }
                } else {
                    this.$store.commit("tip", res);
                }
            }
        },
        created() {
            this.fullHeight = "height:" + (document.documentElement.clientHeight) + "px";
            sessionStorage.setItem("loading", "true");
        },
        mounted() {
            setTimeout(() => {
                this.loginStyle = "opacity: 1;top:0;"
            }, 10)
        }
    }
</script>

<style scoped>
    .submit {
        position: fixed;
        /*transition: all 1.5s;*/
        opacity: 0;
        top: 10px;
        bottom: 10px;
        right: 0;left: 0;
        margin: auto;
        border: 1px solid rgba(145, 144, 144, 0.66);
        /*background-color: rgba(255, 255, 255, 0.66);*/
        z-index: 10;
        padding: 5px 10px;
    }
</style>
