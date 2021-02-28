<template>
    <div class="signIn">
        <font-awesome-icon icon="user" class="icon--user" />
        <form>
            <auth-input
                icon="envelope" type="email" placeholder="メールアドレス"
                v-model="user.email" :authFunction="userSignIn"
            />
            <auth-input
                icon="key" type="password" placeholder="パスワード"
                v-model="user.password" :authFunction="userSignIn"
            />
        </form>
        <button class="btn btn-success" @click="userSignIn()">ログイン</button>
    </div>
</template>

<script>
import axios from 'axios'
import AuthInput from './AuthInput'

export default {
  components: { AuthInput },
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
                alert("ログインできませんでした。入力内容が正しいか、通信環境をご確認下さい。")
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
</style>
