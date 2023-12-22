<template>
    <div class="infoIntroduce">
        <img src="@/assets/example.jpg" style="width: 100%;height: 300px;margin: 10px 0;">
        <div class="introduceBlock">
            <div class="introduceTitle" :class="$route.path==='/press' ? 'activeIntroduce' : 'introduceTitle' ">公司简介</div>
            <div class="introduceTitle" :class="$route.path==='/press' ? 'activeIntroduce' : 'introduceTitle' ">联系我们</div>
        </div>
        <div style="margin: 15px 0;font-size: 20px;font-weight: bold">
            演示数据展示
        </div>
        <div style="display: flex;justify-content: center">
            <div>演示:</div>
            <div style="margin-left: 10px;">演示数据展示演示数据展示演示数据展示演示数据展示演示数据展示</div>
        </div>
        <div style="display: flex;justify-content: center;margin: 10px 0;">
            <div>演示:</div>
            <div style="margin-left: 10px;">演示数据展示演示数据展示演示数据展示演示数据展示演示数据展示</div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "press1",
    }
</script>

<style scoped>
    .infoIntroduce{
        width: 85%;
        text-align: center;
        margin: 0 auto;
    }

    .introduceTitle{
        margin: 6px 10px;color: #8f8f8f;
        cursor: pointer;
    }

    .introduceBlock{
        display: flex;justify-content: center;
        padding: 0 0 8px 0;
        border-bottom: 1px solid #dddddd;
    }

    .introduceTitle:hover{
        color: #62bb05;
    }
    .activeIntroduce{
        color: #62bb05;
    }
</style>