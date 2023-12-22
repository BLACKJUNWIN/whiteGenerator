<#assign tableName = data.humpName?cap_first>
<#assign tableData = data.data>
<template>
    <div style="width: 100%">
        <!--        过滤面板-->
        <el-card style="width: 90%;border-radius: 1em;margin:30px auto">
            <div style="font-size: 35px;font-weight: bold">筛选</div>
            <el-form label-position="top" style="width:80%;margin-top:20px" inline>
                <#list tableData as item>
                    <#if item.canSelect>
                        <el-form-item label="${item.comment}">
                            <#if item.canEnum>
                                <el-select v-model="formFilter.${item.humpColumn}" placeholder="请选择${item.comment}">
                                    <#list item.enumList as enum>
                                        <el-option label="${enum.name}" value="${enum.value}"/>
                                    </#list>
                                </el-select>
                            <#else>
                                <el-input v-model="formFilter.${item.humpColumn}" placeholder="请输入${item.comment}"/>
                            </#if>
                        </el-form-item>
                    </#if>
                </#list>
            </el-form>
            <div style="display: flex;justify-content: right;margin-top:30px">
                <el-button type="success" @click="addBefore()">新增</el-button>
                <el-button type="primary" @click="finds()">搜索</el-button>
                <el-button type="info" @click="reset();list()">重置</el-button>
            </div>
        </el-card>
        <!--        表单数据-->
        <el-table :data="tableData" stripe class="tableStyle" style="width: 90%">
            <#list tableData as item>
                <#if item.humpColumn!="id">
                    <#if item.canEnum>
                        <el-table-column prop="${item.humpColumn}" label="${item.comment}">
                            <template #default="scope">
                                <el-tag>{{scope.row.${item.humpColumn}}}</el-tag>
                            </template>
                        </el-table-column>
                    <#elseif item.humpColumn?contains("Time")>
                        <el-table-column prop="${item.humpColumn}" label="${item.comment}">
                            <template #default="scope" v-if="tableData.length>0">
                                <span>{{ formatDate(scope.row.${item.humpColumn}) }}</span>
                            </template>
                        </el-table-column>
                    <#else>
                        <el-table-column prop="${item.humpColumn}" label="${item.comment}"/>
                    </#if>
                </#if>
            </#list>
            <el-table-column prop="status" label="操作" width="200px" fixed="right">
                <template #default="scope">
                    <el-button-group>
                        <el-button type="warning" icon="Edit" @click="modifyBefore(scope.row.id)"
                                   :disabled="store.state.role!=='管理员'">修改
                        </el-button>
                        <el-popconfirm title="确认删除该数据?" @confirm="remove(scope.row.id)"
                                       :disabled="store.state.role!=='管理员'">
                            <template #reference>
                                <el-button type="danger" icon="Delete">删除</el-button>
                            </template>
                        </el-popconfirm>
                    </el-button-group>
                </template>
            </el-table-column>
        </el-table>
        <!--        分页按钮-->
        <el-pagination style="width:90%;margin:10px auto" background layout="prev, pager, next"
                       :total="parseInt(data.total)" v-model:current-page="formFilter.pageNum" @current-change="finds()"
                       :page-size="15"/>
    </div>
    <!--        编辑面板/新增/修改-->
    <el-dialog v-model="data.dialogFormVisible" title="编辑面板" draggable :close-on-click-modal="false"
               style="padding:20px 60px;width:600px;border-radius: 1em"
               :close-on-press-escape="false">
        <el-form label-position="top">
            <#list tableData as item>
                <#if item.canEdit>
                    <el-form-item label="${item.comment}">
                        <#if item.canEnum>
                            <el-select v-model="formParam.${item.humpColumn}" clearable placeholder="请选择${item.comment}">
                                <#list item.enumList as enum>
                                    <el-option label="${enum.name}" value="${enum.value}"/>
                                </#list>
                            </el-select>
                        <#else >
                            <#if item.type=="int">
                                <el-input-number v-model="formParam.${item.humpColumn}"/>
                            <#else >
                                <el-input v-model="formParam.${item.humpColumn}" placeholder="请输入${item.comment}"/>
                            </#if>
                        </#if>
                    </el-form-item>
                </#if>
            </#list>
        </el-form>
        <template #footer>
      <span class="dialog-footer">
        <el-button type="primary" @click="uploadData()">确定</el-button>
        <el-button type="info" @click="data.dialogFormVisible = false">
          取消
        </el-button>
      </span>
        </template>
    </el-dialog>
</template>

<script setup>
    import {onMounted, reactive, ref} from "vue";
    import {
        net_add${tableName},
        net_remove${tableName},
        net_find${tableName},
        net_list${tableName},
        net_modify${tableName}
    } from "@/api/${data.name}";
    import {useStore} from "vuex";
    import {formatDate} from "@/utils/timeUtil";
    //基础数据
    const store = useStore()
    //表格数据
    const tableData = ref([]);
    //过滤面板数据
    const formFilter = ref({
        <#list tableData as item>
        <#if item.canSelect>
        ${item.humpColumn}: "",
        </#if>
        </#list>
        pageNum: 1,
        pageSize: 10
    })
    //编辑面板表单数据
    const formParam = ref({
        <#list tableData as item>
        <#if item.canEdit>
        ${item.humpColumn}: "",
        </#if>
        </#list>
    })
    //全局参数
    let data = reactive({
        total: 0,
        dialogFormVisible: false,
        isAdd: true,
    })

    onMounted(async () => {
        await list();
    })
    //获取数据
    let list = async () => {
        let res = await net_find${tableName}(formFilter.value);
        if (res.code === 200) {
            tableData.value = res.data.list;
            data.total = res.data.total;
        }
    }
    //新增之前
    let addBefore = () => {
        data.isAdd = true;
        reset();
        data.dialogFormVisible = true;
    }
    //新增
    const add = async () => {
        let res = await net_add${tableName}(formParam.value);
        store.commit("tip", res);
        await list();
    }
    //删除
    const remove = async (id) => {
        let res = await net_remove${tableName}(id);
        store.commit("tip", res);
        await list();
    }
    //修改之前
    const modifyBefore = async (id) => {
        data.isAdd = false;
        reset();
        let res = await net_find${tableName}({id: id, pageNum: 1, pageSize: 10});
        formParam.value = res.data.list[0];
        data.dialogFormVisible = true;
    }
    //修改
    const modify = async () => {
        let res = await net_modify${tableName}(formParam.value);
        store.commit("tip", res);
        await list();
    }
    //查找
    const finds = async () => {
        let res = await net_find${tableName}(formFilter.value);
        if (res.code === 200) {
            tableData.value = res.data.list;
        }
    }
    //新增/修改按钮
    const uploadData = () => {
        if (formVerify()) {
            if (data.isAdd) {
                add();
            } else {
                modify();
            }
            data.dialogFormVisible = false;
            reset();
        }
    }
    //表单验证
    const formVerify = () => {
        let res = {
            code: 500,
            message: ""
        }
        if(false){}
        <#list tableData as item>
            <#if item.canEdit>
                    <#if item.canEnum>
                    else if (formParam.value.${item.humpColumn} === undefined || formParam.value.${item.humpColumn} === "") {
                        res.message += "请选择${item.comment}"
                    }
                    <#else>
                    else if (formParam.value.${item.humpColumn} === undefined || formParam.value.${item.humpColumn} === "") {
                        res.message += "请填写${item.comment}"
                    }
                    </#if>
            </#if>
        </#list>

        if (res.message === "") {
            return true;
        }
        store.commit("tip", res);
        return false;
    }
    //重置表单
    const reset = () => {
        formFilter.value = {
            <#list tableData as item>
            <#if item.canSelect>
            ${item.humpColumn}: "",
            </#if>
            </#list>
            pageNum: 1,
            pageSize: 10
        }
        formParam.value = {
            <#list tableData as item>
            <#if item.canEdit>
            ${item.humpColumn}: "",
            </#if>
            </#list>
        }
    }
</script>

<style>

</style>