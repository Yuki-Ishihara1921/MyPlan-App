<template>
    <div>
        <div class="button-fixed--add">
            <button class="btn btn-info btn-lg rounded-circle" @click="showModal()">＋</button>
        </div>
        <modal name="modal-plan--create">
            <form class="position-relative">
                <h3>プラン作成</h3>
                <div class="form-group">
                    <label>● プラン名(必須)</label>
                    <input class="form-control w-100 m-auto" type="text" v-model="newPlan.name">
                </div>
                <div class="form-group">
                    <label>● 日程</label>
                    <div class="d-flex">
                        <input class="form-control" type="date" v-model="newPlan.start" placeholder="Start">
                        <p class="mx-0 my-auto">〜</p>
                        <input class="form-control" type="date" v-model="newPlan.end" placeholder="End">
                    </div>
                </div>
                <div class="form-group">
                    <label>● 日数</label>
                    <input class="form-control w-50" type="text" v-model="newPlan.days" placeholder="例：2泊3日" maxlength="7">
                </div>
                <div class="form-buttons">
                    <button class="btn btn-primary mx-2" @click="createPlan()">作成</button>
                    <button class="btn btn-secondary mx-2" @click="hideModal()">戻る</button>
                </div>
            </form>
        </modal>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    data () {
        return {
            newPlan: {
                name: "",
                start: "",
                end: "",
                days: ""
            }
        }
    },
    props: {
        getPlans: Function
    },
    methods: {
        createPlan () {
            const res = window.confirm("こちらの内容でプランを作成しますか？")
            if (!res) {
                return false
            } else {
                if (this.newPlan.name === "") {
                    alert("プラン名がありません。")
                } else {
                    axios
                    .post(`api/plans`, this.newPlan, {
                        headers: { 'Authorization': this.$cookies.get('usertoken') }
                    })
                    .then(response => {
                        this.hideModal()
                        this.getPlans()
                        this.newPlan = { name: "", start: "", end: "", days: "" }
                        window.scrollTo({ top: 0 })
                    })
                }
            }
        },
        showModal () {
            this.$modal.show("modal-plan--create")
        },
        hideModal () {
            this.$modal.hide("modal-plan--create")
        }
    }
}
</script>

<style scoped>
.form-group label {
    margin: 0;
}
.form-buttons {
    position: absolute;
    right: 60px;
    bottom: 0;
}
</style>
