<#--纯封装组件-->

<template>
    <div style="width: 100%;">
<#--        <img src="@/assets/example.jpg" style="height: 400px;width: 100%;">-->
        <div style="text-align: center;font-size: 20px;margin: 10px 0;">
            ....网站
        </div>
        <div style="width: 30%;margin: 20px auto;">
            <el-input type="text" v-model="userName" style="margin: 10px 0;" placeholder="用户名"></el-input>
            <el-input type="password" v-model="password" style="color: #d90606;margin: 10px 0;" placeholder="密码"></el-input>
            <div class="loginButton">登录</div>
            <div class="registerButton">注册</div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "loginModel",
        data(){
            return{
                userName: '',
                password:''
            }
        }
    }
</script>

<style scoped>
    /deep/ .el-input__inner::placeholder {
        color: #696969;
        text-align:left;
    }

    .loginButton{
        margin: 10px 0;
        height: 50px;
        background-color: #70b8fc;
        border-radius: 8px;
        text-align: center;
        line-height: 50px;
        color: #FFFFFF;
        cursor: pointer;
    }
    .loginButton:hover{
        opacity: .9;
    }

    .registerButton{
        margin: 10px 0;
        height: 50px;
        background-color: #70fc91;
        border-radius: 8px;
        text-align: center;
        line-height: 50px;
        color: #FFFFFF;
        cursor: pointer;
    }

    .registerButton:hover{
        opacity: .9;
    }
</style>