import Vue from 'vue'
import VueRouter from 'vue-router'
import { Sample, Sample2 } from './pages'

Vue.use(VueRouter)

const router = new VueRouter({
    routes: [
        { path: '/', name: 'Sample', component: Sample },
        { path: '/sample2', name: 'Sample2', component: Sample2 }
    ]
})

export default router