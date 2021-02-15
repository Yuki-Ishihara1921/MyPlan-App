<template>
    <div class="signIn">
        <font-awesome-icon icon="user" class="icon--user" />
        <form>
            <div class="form-group d-flex">
                <font-awesome-icon icon="envelope" class="icon--auth" />
                <input class="form-control" type="email" v-model="user.email" placeholder="メールアドレス" @keyup.enter="userSignIn()">
            </div>
            <div class="form-group d-flex">
                <font-awesome-icon icon="key" class="icon--auth" />
                <input class="form-control" type="password" v-model="user.password" placeholder="パスワード" @keyup.enter="userSignIn()">
            </div>
        </form>
        <button class="btn btn-success" @click="userSignIn()">ログイン</button>
    </div>
</template>

<script>
import axios from 'axios'

export default {
    data () {
        return {
            user: {
                email: "",
                password: ""
            }
        }
    },
    methods: {
        userSignIn () {
            const user = this.user
            if (user.email === "" || user.password === "") {
                alert("未入力の項目があります。")
                return false
            }
            axios
            .post('/api/sessions', this.user)
            .then(response => {
                const data = response.data
                this.$cookies.set('user', data.user)
                this.$cookies.set('usertoken', data.token)
                this.$router.push({ name: 'PagePlanList' })
            })
            .catch((error) => {
                alert("ログインに失敗しました。通信環境をご確認下さい。")
                throw new Error(error)
            })
        }
    }
}
</script>

<style scoped>
.signIn {
    width: 300px;
    margin: auto;
    text-align: center;
}
.icon--user {
    width: 100px !important;
    margin: 1rem;
    padding: 20px;
    border: 1px solid;
    border-radius: 50%;
    background: #fff;
    color: cadetblue;
    font-size: 100px;
}
.icon--auth {
    margin: auto 10px auto 0;
    font-size: 20px;
}
</style>
