<template>
    <div class="form-group d-flex">
        <font-awesome-icon :icon="icon" class="icon--auth" />
        <input
            class="form-control" :type="type" :placeholder="placeholder"
            :value="value" @input="$emit('input', $event.target.value)"
            @keyup.enter="authFunction()"
        >
    </div>
</template>

<script>
export default {
    props: {
        icon: "",
        type: "",
        placeholder: "",
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