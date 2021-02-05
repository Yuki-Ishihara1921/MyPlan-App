import Vue from 'vue'
import VueRouter from 'vue-router'
import { PageAuth, PagePlanList, PageOutlineList, PageDetailList } from './pages'

Vue.use(VueRouter)

const router = new VueRouter({
    routes: [
        { path: '/signin', name: 'PageAuth', component: PageAuth },
        { path: '/', name: 'PagePlanList', component: PagePlanList },
        { path: '/planlist/:id(\\d+)/outlines', name: 'PageOutlineList', component: PageOutlineList },
        { path: '/planlist/:id(\\d+)/details', name: 'PageDetailList', component: PageDetailList }
    ]
})

export default router