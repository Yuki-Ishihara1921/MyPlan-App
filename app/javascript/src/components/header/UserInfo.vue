<template>
    <b-dropdown class="mr-2" right size="sm" variant="info">
        <template #button-content>
            <font-awesome-icon icon="user" />
        </template>
        <b-dropdown-item disabled>
            <h5 class="m-0 text-center text-primary">{{username}}</h5>
        </b-dropdown-item>
        <b-dropdown-divider />
        <b-dropdown-item href="#" class="text-center" @click="userSignout()">
            ログアウト
        </b-dropdown-item>
    </b-dropdown>
</template>

<script>
export default {
    data () {
        return {
            username: ""
        }
    },

    mounted () {
        this.username = this.$cookies.get('user').name
    },

    methods: {
        userSignout () {
            const res = window.confirm("サインアウトしますか？")
            if (!res) {
                return false
            } else {
                this.$cookies.remove('user')
                this.$cookies.remove('usertoken')
                this.$router.push({ name: 'PageAuth' })
            }
        }
    }
}
</script>
