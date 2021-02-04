<template>
    <div>
        <h1>Sample1</h1>
        <button @click="goSample2()">Sample2</button>
    </div>
</template>

<script>
export default {
    methods: {
        goSample2 () {
            this.$router.push('/sample2')
        }
    }
}
</script>

<style>

</style>