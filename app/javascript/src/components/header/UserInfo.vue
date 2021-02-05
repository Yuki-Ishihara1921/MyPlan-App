<template>
    <span class="m-1">
        <button class="btn btn-info rounded-circle" @click="() => isOpen=!isOpen">
            <font-awesome-icon icon="user" class="text-white" />
        </button>
        <div v-if="isOpen" class="userinfo-menu w-100 m-0 p-0">
            <h4 class="m-auto p-3 text-primary">{{username}}</h4>
            <a href="#" class="dropdown-item border-top" @click.prevent.stop="userSignout()">サインアウト</a>
        </div>
    </span>
</template>

<script>
export default {
    data () {
        return {
            username: "",
            isOpen: false
        }
    },
    mounted () {
        this.getUserName()
    },
    methods: {
        getUserName () {
            const user = this.$cookies.get('user')
            this.username = this.$cookies.get('user').name
        },
        userSignout () {
            const res = window.confirm("こちらのアカウントをサインアウトしますか？")
            if (!res) {
                return false
            } else {
                this.$cookies.remove('user')
                this.$cookies.remove('usertoken')
                this.$router.push({ name: 'PageAuth' })
            }
        },
        showModal() {
            this.$modal.show("modal--userinfo")
        },
        hideModal() {
            this.$modal.hide("modal--userinfo")
            this.isOpen = false
        }
    }
}
</script>

<style scoped>
.userinfo__block {
    position: relative;
    margin-left: auto;
    padding: 5px 10px;
    background: aliceblue;
    border-left: 5px solid gainsboro;
    text-align: center;
}
.userinfo-menu {
    display: block;
    position: absolute;
    top: 100%;
    right: 0;
    z-index: 1000;
    min-width: 12rem;
    background-color: #fff;
    border: 1px solid rgba(0, 0, 0, 0.15);
    border-radius: 0.25rem;
}
</style>