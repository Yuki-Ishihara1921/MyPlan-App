<template>
    <b-button
        class="btn rounded-circle"
        :class="className"
        @click="clickFunction"
    >
        <font-awesome-icon v-if="isIcon" :icon="label" />
        <span v-else>{{label}}</span>
    </b-button>
</template>

<script>
export default {
    props: {
        className: String,
        isIcon: Boolean,
        label: String,
        clickFunction: Function
    }
}
</script>

<style>

</style>