<#--有接口调用,甜品网站已用-->

<template>
    <div class="login">
        <div style="width: 40%;display: flex;position: absolute;top:32%;left: 32%;">
            <div style="text-align: center;font-size: 20px;;width: 30%;background: white;height: 400px;line-height: 400px;border-bottom-left-radius: 8px;border-top-left-radius: 8px;">
                ${}
            </div>
            <div style="width: 70%;margin:0 auto;height: 400px;background: rgba(100,100,100,0.36);padding: 0 15px;">
                <label class="loginLabel">用户名</label>
                <el-input type="text" v-model="user.userName" style="margin: 10px 0;height: 60px;" placeholder="用户名"></el-input>
                <label class="loginLabel">密码</label>
                <el-input type="password" v-model="user.password" style="color: #d90606;margin: 10px 0;height: 60px;" placeholder="密码"></el-input>
                <div style="width: 100%;text-align: center">
                    <el-radio v-model="role" label="user"><strong>用户</strong></el-radio>
                    <el-radio v-model="role" label="admin"><strong>管理员</strong></el-radio>
                </div>
                <div class="loginButton"  @click="login()">登录</div>
                <div class="registerButton" @click="isLogin=false;registerUser()" >注册</div>
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
                    if (res.code === "200") {
                        if (this.role === "admin") {
                            if (res.data.role !== "admin") {
                                res = {
                                    code: "500",
                                    message: "用户权限不够!"
                                }
                            } else {
                                sessionStorage.setItem("id", res.data.userId);
                                sessionStorage.setItem("user", res.data.userName);
                                await this.$router.push("/back_home/user");
                            }
                        } else {
                            sessionStorage.setItem("id", res.data.id);
                            sessionStorage.setItem("user", res.data.userName);
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
                if (this.user.userName === '') {
                    res.message = "用户名为空"
                } else if (this.user.password === '') {
                    res.message = "密码为空"
                }
                if (res.message === '') {
                    let uploadUser = {
                        userName: this.user.userName,
                        password:this.user.password,
                        role: "user",
                    }
                    let res = await net_register(uploadUser);
                    if(res.code==="200"){
                        this.isLogin=true;
                    }
                    this.$store.commit("tip", res);
                    this.registers = {
                        userName: '',
                        password: '',
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
        border-radius: 10%;
        width: 490px;
        z-index: 10;
        padding: 5px 10px;
    }
    .login{
        /*background: url("~@/assets/images/bg.jpg") no-repeat;*/
        background-size:100%;
        height: 100vh;
    ;position: relative
    }
    .loginLabel{
        color: white;
        height: 40px;
        line-height: 40px;
    }
    .el-radio{
        color: white;
    }

</style>
