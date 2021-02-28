<template>
    <div>
        <div class="planNewButton">
            <button class="btn btn-info btn-lg rounded-circle" @click="showModal()">＋</button>
        </div>
        <modal name="modal--newPlan">
            <form class="px-5 py-3">
                <h4 class="text-primary text-center">新規作成</h4>
                <div class="form-group">
                    <label>● プラン名(必須)</label>
                    <input
                        class="form-control w-100 m-auto"
                        type="text"
                        v-model="newPlan.name"
                        placeholder="例：東京観光"
                    >
                </div>
                <div class="form-group">
                    <label>● 日程</label>
                    <div class="d-flex">
                        <input
                            class="form-control"
                            type="date"
                            v-model="newPlan.start"
                            placeholder="Start"
                        >
                        <p class="mx-2 my-auto">〜</p>
                        <input
                            class="form-control"
                            type="date"
                            v-model="newPlan.end"
                            placeholder="End"
                        >
                    </div>
                </div>
                <div class="d-flex">
                    <div class="form-group">
                        <label>● 日数</label>
                        <input
                            class="form-control"
                            type="text"
                            v-model="newPlan.days"
                            placeholder="例：2泊3日"
                            maxlength="7"
                        >
                    </div>
                    <div class="planNewButton-complete">
                        <button class="btn btn-success" @click="createPlan()">作成</button>
                    </div>
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
                    .then(() => {
                        this.hideModal()
                        this.getPlans()
                        this.newPlan = { name: "", start: "", end: "", days: "" }
                        window.scrollTo({ top: 0 })
                    })
                }
            }
        },

        showModal () {
            this.$modal.show("modal--newPlan")
        },

        hideModal () {
            this.$modal.hide("modal--newPlan")
        }
    }
}
</script>

<style lang='scss' scoped>
.planNewButton {
    position: fixed;
    right: 20px;
    bottom: 20px;
    &-complete {
        margin: auto auto 1rem;
        & button {
            width: 100px;
        }
    }
}
</style>
