import request from "./request"
<#assign tableName = data.humpName?cap_first>
<#assign tableData = data.data>
//新增
export function net_add${tableName}(data){
    return request({
        url:"/${data.humpName}/",
        method:"post",
        data
    })
}
//删除
export function net_remove${tableName}(id){
    return request({
        url:"/${data.humpName}/"+id,
        method:"delete"
    })
}
//修改
export function net_modify${tableName}(data){
    return request({
        url:"/${data.humpName}/",
        method:'put',
        data
    })
}
//查询
export function net_list${tableName}(){
    return request({
        url:"/${data.humpName}/",
        method:'get'
    })
}
//查询
export function net_find${tableName}(data){
    return request({
        url:"/${data.humpName}/",
        method:"patch",
        data
    })
}
<#if data.name="user">
//登录
export function net_login(data){
    return request({
        url:"/${data.humpName}/login",
        method:"post",
        data
    })
}
//注册
export function net_register(data){
    return request({
        url:"/${data.humpName}/register",
        method:"post",
        data
    })
}
</#if>