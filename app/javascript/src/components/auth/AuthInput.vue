<template>
    <div class="form-group d-flex">
        <font-awesome-icon class="icon--auth" :icon="icon" />
        <input
            class="form-control"
            :placeholder="placeholder"
            :type="type"
            :value="value"
            @input="$emit('input', $event.target.value)"
            @keyup.enter="authFunction()"
        >
    </div>
</template>

<script>
export default {
    props: {
        icon: "",
        placeholder: "",
        type: "",
        value: "",
        authFunction: Function
    }
}
</script>

<style scoped>
.icon--auth {
    margin: auto 10px auto 0;
    font-size: 20px;
}
</style>