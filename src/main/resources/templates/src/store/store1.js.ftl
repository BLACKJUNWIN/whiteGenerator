import { createStore } from 'vuex'
import { ElMessage } from 'element-plus'
/**
 * 创建仓库和导出
 */
export default createStore({
    state: {
        loading:false,
        userName:"",
    },
    mutations: {
        // eslint-disable-next-line no-unused-vars
        tip(state,res){
            if(res.code===200){
                if(res.message!==null&&res.message!==""){
                    ElMessage({
                        message: res.message,
                        type: 'success',
                    })
                }else{
                    ElMessage({
                        message: '操作成功',
                        type: 'success',
                    })
                }
            }else{
                ElMessage({
                    message: res.message,
                    type: 'warning',
                })
            }
        }
    },
    actions: {
    },
    modules: {
    }
})