<template>
    <div class="pagePlanList">
        <the-header :isPagePlanList="isPagePlanList">
            <h1 slot="pageName" class="mx-3 my-auto">Plan List</h1>
        </the-header>
        <main>
            <app-spinner v-if="isLoading" />
            <div v-else class="container">
                <h4 v-if="plans.length === 0" class="m-5 text-center text-warning">プランを登録して下さい。</h4>
                <plan-index v-else :plans="plans" :getPlans="getPlans" />
                <plan-new :getPlans="getPlans" />
            </div>
        </main>
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
            isLoading: true,
            plans: []
        }
    },

    beforeCreate () {
        const jwt = this.$cookies.get('usertoken')
        if (!jwt) {
            this.$router.push({ name: 'PageAuth' })
        }
    },

    mounted () {
        this.getPlans()
    },
    
    methods: {
        getPlans () {
            axios
            .get(`/api/plans.json`, {
                headers: { 'Authorization': this.$cookies.get('usertoken') }
            })
            .then(response => {
                this.plans = response.data
                this.isLoading = false
            })
            .catch(() => {
                this.$router.push({ name: 'PageAuth' })
            })
        },

    }
}
</script>

<style scoped>
.pagePlanList {
    min-width: 500px;
}
</style>