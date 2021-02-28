<template>
    <div class="signUp">
        <a href="#" @click.prevent.stop="showModal()">アカウント登録はこちら</a>
        <modal name="modal--signUp">
            <div class="px-5">
                <h4 class="m-3 text-primary">アカウント登録</h4>
                <form>
                    <auth-input
                        icon="user-circle" type="text" placeholder="ユーザー名"
                        v-model="newUser.name" :authFunction="userSignUp"
                    />
                    <auth-input
                        icon="envelope" type="email" placeholder="メールアドレス"
                        v-model="newUser.email" :authFunction="userSignUp"
                    />
                    <auth-input
                        icon="key" type="password" placeholder="パスワード (8文字以上)"
                        v-model="newUser.password" :authFunction="userSignUp"
                    />
                    <auth-input
                        icon="key" type="password" placeholder="パスワード (確認用)"
                        v-model="newUser.password_confirmation" :authFunction="userSignUp"
                    />
                    <button class="btn btn-success m-auto" @click="userSignUp()">登録</button>
                </form>
            </div>
        </modal>
        <app-spinner v-if="isSignUpLoading" text="アカウント登録中..." />
    </div>
</template>

<script>
import axios from 'axios'
import AuthInput from './AuthInput'
import { isValidEmailFormat } from './authFunctions'
import AppSpinner from '../parts/AppSpinner.vue'

export default {
    components: {
        AuthInput,
        AppSpinner
    },
    data () {
        return {
            newUser: {
                name: "",
                email: "",
                password: "",
                password_confirmation: ""
            },
            isSignUpLoading: false
        }
    },
    methods: {
        userSignUp () {
            const user = this.newUser
            if (user.name === "" || user.email === "" || user.password === "" || user.password_confirmation === "") {
                alert("未入力の項目があります。")       
                return false
            }
            if (!isValidEmailFormat(user.email)) {
                alert("メールアドレスの形式が正しくありません。")
                return false
            }
            if (user.password.length < 8) {
                alert("パスワードは8文字以上で入力して下さい。")
                return false
            }
            if (user.password !== user.password_confirmation) {
                alert("パスワードが一致しておりません。")
                return false
            }
            else {
                const res = window.confirm("こちらの内容でアカウントを登録しますか？")
                if (!res) {
                    return false
                } else {
                    this.isSignUpLoading = true
                    axios
                    .post('/api/users', user)
                    .then(response => {
                        const data = response.data
                        if (data) {
                            this.$cookies.set('user', data.user)
                            this.$cookies.set('usertoken', data.token)
                            this.$router.push({ name: 'PagePlanList' })
                            alert("アカウントが登録されました！")
                            this.isSignUpLoading = false
                        }
                    })
                    .catch((error) => {
                        this.isSignUpLoading = true
                        alert("アカウントが登録されませんでした。通信環境をご確認下さい。")
                        throw new Error(error)
                    })
                }
            }
        },

        showModal () {
            this.newUser = { name: "", email: "", password: "", password_confirmation: "" }
            this.$modal.show("modal--signUp")
        }
    }
}
</script>

<style scoped>
.signUp {
    margin: 1rem;
    text-align: center;
}
</style>