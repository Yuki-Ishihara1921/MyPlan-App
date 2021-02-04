<template>
    <div>
        <h2>Sample2</h2>
        <button @click="goSample()">Sample</button>
    </div>
</template>

<script>
export default {
    methods: {
        goSample () {
            this.$router.push({ name: 'Sample' })
        }
    }
}
</script>

<style>

</style>