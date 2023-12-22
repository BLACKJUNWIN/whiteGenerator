import Vue from 'vue'
import store from "@/store/index";
import Router from 'vue-router'

import home from "../views/before/home";
import login from "../views/login";
import mine from "../views/before/item/mine";
import good from "../views/before/item/good";
import index from "../views/before/item/index"
import goodInfo from "../views/before/item/goodInfo";
import press from "../views/before/item/press";
<#list data as table>
import back_${table.name} from "@/views/back/back_${table.name}";
</#list>
import feedBack from "../views/before/item/feedBack";

Vue.use(Router)

const originalPush = Router.prototype.push
Router.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

const router = new Router({
  routes: [
    {
      path: '/',
      redirect: "/home/index"
    },
    {
      path: "",
      redirect: "/home/index"
    },
    {
      path: "/login",
      component: login
    },
    {
      path: '/back',
      component: back,
      children: [
        {
          path: '/',
          redirect: "/back/user"
        },
        {
          path: "",
          redirect: "/back/user"
        },
        <#list data as table>
            {
            path: "/${table.name}",
            name: "${table.comment}管理",
            meta: {
                token: true
            },
            component: back_${table.name}
            },
        </#list>
      ]
    },
    {
      path: "/home",
      component: home,
      children: [
        {
          path: "mine",
          component: mine,
          meta: {
            token: true
          }
        },
        {
          path: "good",
          component: good
        },
        {
          path: "press",
          component: press
        },
        {
          path: "index",
          component: index
        },
        {
          path:"good_info",
          component: goodInfo
        },
        {
          path:'feedBack',
          component: feedBack
        }
      ]
    },
  ]
})

// router.beforeEach((to, from, next) => {
//   if (to.meta.token) {
//     if (sessionStorage.getItem("id")) {
//       return next();
//     } else {
//       let res = {
//         code: "500",
//         message: "请先登录"
//       }
//       store.commit("tip", res);
//       return next("/login");
//     }
//   }
//   return next();
// });

export default router;
