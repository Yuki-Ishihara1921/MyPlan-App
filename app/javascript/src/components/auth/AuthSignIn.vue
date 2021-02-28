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
        <app-loading v-if="isSignInLoading" text="ログイン中..." />
    </div>
</template>

<script>
import axios from 'axios'
import AuthInput from './AuthInput'
import { AppLoading } from '../parts'
import { isValidEmailFormat } from './authFunctions'

export default {
    components: { AuthInput, AppLoading },

    data () {
        return {
            user: {
                email: "",
                password: ""
            },
            isSignInLoading: false
        }
    },
    methods: {
        userSignIn () {
            this.isSignInLoading = true
            const user = this.user
            if (user.email === "" || user.password === "") {
                this.isSignInLoading = false
                alert("未入力の項目があります。")
                return false
            }
            if (!isValidEmailFormat(user.email)) {
                this.isSignInLoading = false
                alert("メールアドレスの形式が正しくありません。")
                return false
            }
            axios
            .post('/api/sessions', this.user)
            .then(response => {
                this.isSignInLoading = false
                const data = response.data
                this.$cookies.set('user', data.user)
                this.$cookies.set('usertoken', data.token)
                this.$router.push({ name: 'PagePlanList' })
            })
            .catch((error) => {
                this.isSignInLoading = false
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
