<template>
    <div>
        <the-header :isPagePlanList="isPagePlanList">
            <h1 slot="pageName" class="mx-3 my-auto">Plan List</h1>
        </the-header>
        <plan-index />
    </div>
</template>

<script>
import { TheHeader } from '../components/header'
import { PlanIndex, PlanNew } from '../components/plans'

export default {
    components: { TheHeader, PlanIndex, PlanNew },

    data () {
        return {
            isPagePlanList: true
        }
    },

    beforeCreate () {
        const jwt = this.$cookies.get('usertoken')
        if (!jwt) {
            this.$router.push({ name: 'PageAuth' })
        }
    }
}
</script>
