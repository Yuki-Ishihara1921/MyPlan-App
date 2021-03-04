<template>
    <div class="row">
        <section class="plan__container col-lg-6" v-for="plan in plans" :key="plan.id">
            <div class="plan__header" />
            <div class="plan__content">
                <div class="plan__content--infos">
                    <div class="plan__content--infos--name">
                        <input 
                            v-if="inputOpenId === plan.id" placeholder="プラン名(必須)"
                            type="text" v-model="editPlan.name"
                        >
                        <h4 v-else class="text-primary">{{plan.name}}</h4>
                    </div>
                    <div class="d-flex w-100 border-top">
                        <div class="w-35 border-right">
                            <input
                                v-if="inputOpenId === plan.id" type="date"
                                v-model="editPlan.start"
                            >
                            <p v-else>{{plan.start | moment_date}}</p>
                        </div>
                        <div class="border-right">
                            <p>〜</p>
                        </div>
                        <div class="w-35 border-right">
                            <input
                                v-if="inputOpenId === plan.id" type="date"
                                v-model="editPlan.end"
                            >
                            <p v-else>{{plan.end | moment_date}}</p>
                        </div>
                        <div class="w-35">
                            <input
                                v-if="inputOpenId === plan.id" maxlength="7"
                                placeholder="日数" type="text" v-model="editPlan.days"
                            >
                            <p v-else>{{plan.days}}</p>
                        </div>
                    </div>
                </div>
                <div class="plan__content--commands">
                    <router-link :to="{name: 'PageDetailList', params: {id: plan.id}}" class="mr-auto">
                        <button class="btn btn-success">詳細ページ</button>
                    </router-link>
                    <button class="btn btn-info rounded-circle m-auto" v-if="inputOpenId!==plan.id" @click="openInput(plan.id)">
                        <font-awesome-icon icon="edit" />
                    </button>
                    <button class="btn btn-danger rounded-circle m-auto" v-if="inputOpenId!==plan.id" @click="deletePlan(plan.id)">
                        <font-awesome-icon icon="trash" />
                    </button>
                    <button class="btn btn-info rounded-circle m-auto" v-if="inputOpenId===plan.id" @click="updatePlan(plan.id)">
                        <font-awesome-icon icon="check" />
                    </button>
                    <button class="btn btn-secondary rounded-circle m-auto" v-if="inputOpenId===plan.id" @click="closeInput()">
                        ー
                    </button>
                    <router-link :to="{name: 'PageOutlineList', params: {id: plan.id}}" class="ml-auto">
                        <button class="btn btn-primary">概要ページ</button>
                    </router-link>
                </div>
                <div class="p-2 border-top text-right">
                    <font-awesome-icon icon="sync-alt" />
                    <span class="m-0">最終更新 : {{plan.updated_at | moment_datetime}}</span>
                </div>
            </div>
        </section>
        <app-loading v-if="isLoading" :text="loadingText" />
    </div>
</template>

<script>
import axios from 'axios'
import moment from 'moment'
import { AppLoading } from '../parts'

export default {
    components: { AppLoading },

    data () {
        return {
            editPlan: {},
            inputOpenId: 0,
            isLoading: false,
            loadingText: ""
        }
    },

    props: {
        plans: Array,
        getPlans: Function
    },

    filters: {
        moment_date (date) {
            if (date === null) {
                return "- / -"
            } else {
                return moment(date).format("MM / DD")
            }
        },
        moment_datetime (datetime) {
            if (datetime === null) {
                return "- / -"
            } else {
                return moment(datetime).format("yyyy/MM/DD HH:mm")
            }
        }
    },

    mounted () {
        this.getPlans()
    },

    methods: {
        openInput (plan_id) {
            for (var plan of this.plans) {
                if (plan.id === plan_id) {
                    this.editPlan = plan
                    this.inputOpenId = plan_id
                }
            }
        },

        closeInput () {
            this.inputOpenId = -1
            this.getPlans()
        },

        updatePlan (plan_id) {
            if (this.editPlan.name === "") {
                alert("プラン名を入力して下さい。")
                return false
            }
            const res = window.confirm("こちらの内容で更新しますか？")
            if (!res) {
                return false
            } else {
                this.isLoading = true
                this.loadingText = "更新中..."
                axios
                .put(`/api/plans/${plan_id}`, this.editPlan, {
                    headers: { 'Authorization': this.$cookies.get('usertoken') }
                })
                .then(() => {
                    this.inputOpenId = -1
                    this.hideLoading()
                    this.getPlans()
                    window.scrollTo({ top: 0 })
                })
                .catch(() => {
                    alert("更新が完了しませんでした。通信環境をご確認下さい。")
                    this.hideLoading()
                    return false
                })
            }
        },

        deletePlan (plan_id) {
            const res = window.confirm("こちらのプランを削除しますか？")
            if (!res) {
                return false
            } else {
                this.isLoading = true
                this.loadingText = "削除中..."
                axios
                .delete(`/api/plans/${plan_id}`, {
                    headers: { 'Authorization': this.$cookies.get('usertoken') }
                })
                .then(() => {
                    this.hideLoading()
                    this.getPlans()
                })
                .catch(() => {
                    alert("削除できませんでした。通信環境をご確認下さい。")
                    this.hideLoading()
                    return false
                })
            }
        },

        hideLoading () {
            this.isLoading = false
            this.loadingText = ""
        }
    }
}
</script>

<style lang='scss' scoped>
.plan__container {
    max-width: 600px;
    margin: 2rem auto;
}

.plan__header {
    width: 50%;
    height: 35px;
    margin: auto;
    border: 10px solid blanchedalmond;
    border-bottom: 0;
}

.plan__content {
    border: 10px solid blanchedalmond;
    border-radius: 10px;
    box-shadow: 0 2px 2px;
    background: floralwhite;
    &--infos {
        border: 5px solid gainsboro;
        text-align: center;
        &--name input {
            padding: 15px;
            font-size: 20px;
        }
        &--name h4 {
            margin: 15px;
        }
    }
    &--commands {
        display: flex;
        margin: 1rem;
    }
}

.w-35 {
    width: 35%;
}

input {
    width: 100%;
    height: 100%;
    padding: 5px 10px;
}

h4, p {
    margin: 5px;
}
</style>
