<template>
    <div>
        <the-header :isPagePlans="isPagePlans">
            <h1 slot="page-name" class="mx-3 my-auto">Plan List</h1>
        </the-header>
        <plan-index />
    </div>
</template>

<script>
import { TheHeader } from '../components/header'
import { PlanIndex } from '../components/plans'

export default {
    components: { TheHeader, PlanIndex },
    data () {
        return {
            isPagePlans: true
        }
    },
    beforeCreate () {
        const jwt = this.$cookies.get('usertoken')
        if (!jwt) {
            this.$router.push({ name: 'PageAuth' })
        }
    },
}
</script>
