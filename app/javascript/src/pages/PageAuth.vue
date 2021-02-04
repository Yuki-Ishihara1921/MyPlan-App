<template>
  <div>
      <button @click="goSample()">Sample</button>
      <div>
          <h3>ログイン</h3>
          <label>ユーザー名</label>
          <input type="text" v-model="user.name">
          <label>パスワード</label>
          <input type="password" v-model="user.password">
          <button @click="userSignIn()">ログイン</button>
      </div>
      <div>
          <h3>アカウント登録</h3>
          <label>ユーザー名</label>
          <input type="text" v-model="newUser.name">
          <label>パスワード</label>
          <input type="password" v-model="newUser.password">
          <label>パスワード確認用</label>
          <input type="password" v-model="newUser.confirmPassword">
          <button @click="userSignUp()">登録</button>
      </div>
      <button @click="check()">Check</button>
  </div>
</template>

<script>
import axios from 'axios'

export default {
    data () {
        return {
            user: {
                name: "",
                password: ""
            },
            newUser: {
                name: "",
                password: "",
                confirmPassword: ""
            }
        }
    },
    methods: {
        goSample () {
            this.$router.push({ name: 'Sample' })
        },
        check () {
            console.log(this.user)
        },
        userSignIn () {
            const user = this.user
            if (user.name === "" || user.password === "") {
                alert("未入力の項目があります。")
            } else {
                axios
                .post('/api/sessions', this.user)
                .then((response) => {
                    /*
                    const data = response.data
                    this.$cookies.set('user', data.user)
                    this.$cookies.set('usertoken', data.token)
                    */
                    console.log(response.data)
                    this.$router.push({ name: 'Sample' })
                })
                .catch((error) => {
                    alert("もう一度ログインして下さい。")
                    throw new Error(error)
                })
            }
        },
        userSignUp () {
            const newUser = this.newUser
            if (newUser.name === "" || newUser.password === "" || newUser.password_confirmation === "") {
                alert("未入力の項目があります。")       
                return false
            } else if (newUser.password !== newUser.confirmPassword) {
                alert("パスワードが一致しておりません。")
                return false
            } else {
                axios
                .post('/api/users', newUser)
                .then((response) => {
                    /*
                    const data = response.data
                    this.$cookies.set('user', data.user)
                    this.$cookies.set('usertoken', data.token)
                    */
                    console.log(response.data)
                    this.$router.push({ name: 'Sample' })
                    alert("アカウントが登録されました！")
                })
            }
        },
    }
}
</script>

<style>

</style>