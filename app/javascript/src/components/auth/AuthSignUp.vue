<template>
    <div class="m-3 text-center">
        <a href="#" @click.prevent.stop="showModal()">ユーザー作成はこちら</a>
        <modal name="modal-signup" @closed="hideModal">
            <h3 class="text-primary">アカウント登録</h3>
            <form>
                <div class="form-group">
                    <input class="form-control w-100 m-auto" type="text" v-model="newUser.name" placeholder="ユーザー名">
                </div>
                <div class="form-group">
                    <input class="form-control w-100 m-auto" type="password" v-model="newUser.password" placeholder="パスワード">
                </div>
                <div class="form-group">
                    <input class="form-control w-100 m-auto" type="password" v-model="newUser.password_confirmation" placeholder="パスワード(確認用)">
                </div>
                <button class="btn btn-success" @click="userSignUp()">登録</button>
            </form>
            <div class="m-3">
                <a href="#" @click.prevent.stop="hideModal()">ログインに戻る</a>
            </div>
        </modal>
    </div>
</template>

<script>
import axios from 'axios'

export default {
    data () {
        return {
            newUser: {
                name: "",
                password: "",
                password_confirmation: ""
            }
        }
    },
    methods: {
        userSignUp () {
            const newUser = this.newUser
            if (newUser.name === "" || newUser.password === "" || newUser.password_confirmation === "") {
                alert("未入力の項目があります。")       
                return false
            } else if (newUser.password !== newUser.password_confirmation) {
                alert("パスワードが一致しておりません。")
                return false
            } else {
                axios
                .post('/api/users', newUser)
                .then(response => {
                    const data = response.data
                    this.$cookies.set('user', data.user)
                    this.$cookies.set('usertoken', data.token)
                    this.$router.push({ name: 'PagePlans' })
                    alert("アカウントが登録されました！")
                })
            }
        },

        showModal () {
            this.$modal.show("modal-signup")
        },

        hideModal () {
            this.newUser = { name: "", password: "", password_confirmation: "" }
            this.$modal.hide("modal-signup")
        }
    }
}
</script>

<style scoped>

</style>