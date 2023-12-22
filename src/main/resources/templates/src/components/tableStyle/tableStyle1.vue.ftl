<template>
  <div class="tableStyle">
    <el-table size="medium"  :header-cell-style="{background:'#eef1f6',color:'#606266'}" :cell-style="{color:'#3D3A39'}" :data="tableData"  :border="false" :fit="true" :show-header="true"
              :highlight-current-row="false" v-loading="columObj.loading" :row-class-name="tableRowClassName">
      <!-- 普通列 -->
      <el-table-column :prop="item.dataIndex" v-for="(item,index) in columObj.columnData"  :key="index"
                       :label="item.label">
        <template slot-scope="{row,$index}">
          <!-- 默认展示 -->
          <span v-if="item.text && item.editRow !== $index">{{row[item.prop]}}</span>
          <!-- 图片展示 -->
          <img v-if="item.image" :src="row.img" style="width: 30px;height: 40px">
          <!-- 操作按钮 -->
          <span v-if="item.isOperation" v-for="(operations, index) in item.operation" :key="index">
						<el-button v-if="operations.isShow(row,$index)" :icon="operations.icon" :type="operations.type" @click="operations.buttonClick(row,$index)" :style="{color:operations.color,backgroundColor:operations.backgroundColor,fontSize:'18px',margin:'0 6px',padding:'10px'}" size="small">{{operations.label}}</el-button>
					</span>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
export default {
  name:'tableStyle',
  directives: {
    // 自定义指令,用于可编辑input自动获取焦点
    focus: {
      inserted: function(e) {
        e.querySelector('input').focus()
      }
    }
  },
  props: {
    tableData: {
      type: Array,
      required: true
    },
    columObj: {
      type: Object,
      required: true
    },
  },
  data() {
    return {
    }
  },
  methods: {
    // 帮助点击行，获取点击的下标
    tableRowClassName({
                        row,
                        rowIndex
                      }) {
      row.rowIndex = rowIndex;
    },
    // 可编辑input失去焦点
    editInputBlur(row, $index, prop, columIndex) {
      this.$emit('editInputBlur', row, $index, prop, columIndex);
    },
  }
}
</script>
<style scoped>

</style>