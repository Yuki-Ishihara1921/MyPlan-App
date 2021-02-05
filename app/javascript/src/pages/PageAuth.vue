<template>
    <div>
        <app-name />
        <auth-sign-in />
        <auth-sign-up />
    </div>
</template>

<script>
import { AppName } from '../components/parts'
import { AuthSignIn, AuthSignUp } from '../components/auth'

export default {
    components: { AppName, AuthSignIn, AuthSignUp },
    beforeCreate () {
        const jwt = this.$cookies.get('usertoken')
        if (!!jwt) {
            this.$router.push({ name: 'PagePlanList' })
        }
    }
}
</script>

<style>

</style>