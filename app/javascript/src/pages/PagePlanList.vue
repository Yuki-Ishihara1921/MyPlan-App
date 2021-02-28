<template>
    <div class="pagePlanList">
        <the-header :isPagePlanList="isPagePlanList">
            <h1 slot="pageName" class="mx-3 my-auto">Plan List</h1>
        </the-header>
        <main>
            <div class="container">
                <h4 v-if="plans.length === 0" class="m-5 text-center text-warning">プランを登録して下さい。</h4>
                <plan-index v-else :plans="plans" :getPlans="getPlans" />
                <plan-new :getPlans="getPlans" />
            </div>
        </main>
        <app-spinner v-if="isLoading" text="データ取得中..." />
    </div>
</template>

<script>
import axios from 'axios'
import { TheHeader } from '../components/header'
import { AppSpinner } from '../components/parts'
import { PlanIndex, PlanNew } from '../components/plans'

export default {
    components: { TheHeader, AppSpinner, PlanIndex, PlanNew },

    data () {
        return {
            isPagePlanList: true,
            isLoading: false,
            plans: []
        }
    },

    beforeCreate () {
        const usertoken = this.$cookies.get('usertoken')
        if (!usertoken) {
            this.$router.push({ name: 'PageAuth' })
        }
    },

    mounted () {
        this.getPlans()
    },
    
    methods: {
        getPlans () {
            this.isLoading = true
            axios
            .get(`/api/plans.json`, {
                headers: { 'Authorization': this.$cookies.get('usertoken') }
            })
            .then(response => {
                this.plans = response.data
                this.isLoading = false
            })
            .catch(() => {
                this.isLoading = false
                alert("データを取得できませんでした。ログインページに戻ります。")
                this.$router.push({ name: 'PageAuth' })
            })
        }
    }
}
</script>

<style scoped>
.pagePlanList {
    min-width: 500px;
}
</style>