<template>
    <div>
        <button-circle class="planNewButton btn-info btn-lg" label="＋" :clickFunction="() => showModal()" />
        <modal name="modal--newPlan">
            <form class="px-5 py-3">
                <h4 class="text-primary text-center">新規作成</h4>
                <div class="form-group">
                    <label>● プラン名(必須)</label>
                    <input
                        class="form-control w-100 m-auto" placeholder="例：東京観光"
                        type="text" v-model="newPlan.name"
                    >
                </div>
                <div class="form-group">
                    <label>● 日程</label>
                    <div class="d-flex">
                        <input
                            class="form-control" placeholder="Start"
                            type="date" v-model="newPlan.start"
                        >
                        <p class="mx-2 my-auto">〜</p>
                        <input
                            class="form-control" placeholder="End"
                            type="date" v-model="newPlan.end"
                        >
                    </div>
                </div>
                <div class="d-flex">
                    <div class="form-group">
                        <label>● 日数</label>
                        <input
                            class="form-control" maxlength="7"
                            placeholder="例：2泊3日" type="text" v-model="newPlan.days"
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
import { ButtonCircle } from '../parts'

export default {
    components: { ButtonCircle },

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
            if (this.newPlan.name === "") {
                alert("プラン名がありません。")
            }
            const res = window.confirm("こちらの内容でプランを作成しますか？")
            if (!res) {
                return false
            } else {
                axios
                .post(`api/plans`, this.newPlan, {
                    headers: { 'Authorization': this.$cookies.get('usertoken') }
                })
                .then(() => {
                    this.$modal.hide("modal--newPlan")
                    this.getPlans()
                    this.newPlan = { name: "", start: "", end: "", days: "" }
                    window.scrollTo({ top: 0 })
                })
            }
        },

        showModal () {
            this.$modal.show("modal--newPlan")
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
