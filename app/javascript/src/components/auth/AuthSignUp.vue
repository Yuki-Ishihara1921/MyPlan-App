<template>
    <div class="signUp">
        <a href="#" @click.prevent.stop="showModal()">アカウント登録はこちら</a>
        <modal name="modal--signUp">
            <div class="px-5">
                <h4 class="m-3 text-primary">アカウント登録</h4>
                <form>
                    <div class="form-group d-flex">
                        <font-awesome-icon icon="user-circle" class="icon--auth" />
                        <input class="form-control" type="text" v-model="newUser.name" placeholder="ユーザー名">
                    </div>
                    <div class="form-group d-flex">
                        <font-awesome-icon icon="key" class="icon--auth" />
                        <input class="form-control" type="password" v-model="newUser.password" placeholder="パスワード">
                    </div>
                    <div class="form-group d-flex">
                        <font-awesome-icon icon="key" class="icon--auth" />
                        <input class="form-control" type="password" v-model="newUser.password_confirmation" placeholder="パスワード(確認用)">
                    </div>
                    <button class="btn btn-success m-auto" @click="userSignUp()">登録</button>
                </form>
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
            }
            if (newUser.password !== newUser.password_confirmation) {
                alert("パスワードが一致しておりません。")
                return false
            }
            axios
            .post('/api/users', newUser)
            .then(response => {
                const data = response.data
                if (data) {
                    this.$cookies.set('user', data.user)
                    this.$cookies.set('usertoken', data.token)
                    this.$router.push({ name: 'PagePlans' })
                    alert("アカウントが登録されました！")
                }
            })
            .catch((error) => {
                alert("登録されませんでした。通信環境をご確認下さい。")
                throw new Error(error)
            })
        },

        showModal () {
            this.newUser = { name: "", password: "", password_confirmation: "" }
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
.icon--auth {
    margin: auto 10px auto 0;
    font-size: 20px;
}
</style>