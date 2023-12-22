<template>
<div class="bottomModel">
  <div style="display: flex;justify-content: center;margin: 10px 0;">
    <div class="bottomTitle">首页</div>
    <div class="bottomTitle">首页</div>
  </div>
  <div></div>
</div>
</template>

<script>
export default {
  name: "bottomModel"
}
</script>

<style scoped>
.bottomModel {
  height: 200px;
  background-color: #eeeeee;
  width: 100%;
  border-top: 1px solid #dddddd;
  text-align: center;

}

.bottomTitle {
  margin: 0 10px;
  color: #5d5d5d;
  cursor: pointer;
}

.bottomTitle:hover{
  color: #0084FF;
}
</style>