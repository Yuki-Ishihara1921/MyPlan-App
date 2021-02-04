<template>
    <div>
        <h1>Sample1</h1>
        <button @click="goSample2()">Sample2</button>
        <button @click="goSignInPage()">Sign In</button>
    </div>
</template>

<script>
export default {
    methods: {
        goSample2 () {
            this.$router.push('/sample2')
        },
        goSignInPage () {
            this.$router.push('/signin')
        }
    }
}
</script>

<style>

</style>