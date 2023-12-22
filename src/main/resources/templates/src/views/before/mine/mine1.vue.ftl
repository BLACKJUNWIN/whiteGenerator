<#--纯封装组件-->

<template>
    <div style="display: flex;justify-content: space-between;width: 80%;margin: 10px auto;">
        <div style="width: 8%;border: 1px solid #dddddd;border-radius: 4px;height: 92vh">
            <div style="text-align: center;margin: 10px 0;">
                <img src="@/assets/poolActive.svg" style="width: 30px;height: 30px;">
                <div style="margin-top: 20px;" class="mineTitle">用户信息</div>
                <div style="" class="mineTitle">订单信息</div>
            </div>
        </div>
        <div style="border: 1px solid #dddddd;border-radius: 4px;width: 90%;">
            <div style="height: 40px;background-color: #dddddd;color: #1D2129;line-height: 40px;">
                <div style="width: 100px;text-align: center">
                    用户信息
                </div>
            </div>
            <div style="">
                <div style="width: 100%;margin-top: 50px;;display: flex;width: 100%;justify-content: space-between">
                    <div style="text-align: center;width: 20%;">
                        <div><img src="@/assets/poolActive.svg" style="width: 50px;height: 50px;text-align: center"></div>
                        <a-button style="margin-top: 10px;">修改信息</a-button>
                    </div>
                    <div style="width: 75%;">
                        <div style="width: 100%;display: flex">
                            <div>用户名:</div>
                            <div style="margin-left: 10px">admin</div>
                        </div>
                        <div style="width: 100%;display: flex">
                            <div>用户名:</div>
                            <div style="margin-left: 10px">admin</div>
                        </div>
                        <div style="width: 100%;display: flex">
                            <div>用户名:</div>
                            <div style="margin-left: 10px">admin</div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</template>

<script>
    export default {
        name: "mineModel"
    }
</script>

<style scoped>
    .mineTitle{
        width: 100%;;height: 40px;line-height: 40px;
        cursor: pointer;
    }
    .mineTitle:hover{
        color: #0084FF;
        background-color: #dddddd;
    }
</style>