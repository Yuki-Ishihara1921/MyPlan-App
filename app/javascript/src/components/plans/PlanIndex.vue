<template>
    <main class="container">
        <app-spinner v-if="isLoading" />
        <div v-else class="row">
            <div class="plan__contents col-lg-6 my-5" v-for="plan in plans" v-bind:key="plan.id">
                <div class="plan__content-header" />
                <div class="plan__content-main">
                    <div class="main--planInfo">
                        <div>
                            <input v-if="editPlanId===plan.id" type="text" v-model="editPlan.name" style="height: 50px;">
                            <h3 v-else>{{plan.name}}</h3>
                        </div>
                        <div class="d-flex w-100 border-top">
                            <div class="w-35 border-right">
                                <input v-if="editPlanId===plan.id" type="date" v-model="editPlan.start">
                                <p v-else>{{plan.start | moment_date}}</p>
                            </div>
                            <div class="border-right">
                                <p>〜</p>
                            </div>
                            <div class="w-35 border-right">
                                <input v-if="editPlanId===plan.id" type="date" v-model="editPlan.end">
                                <p v-else>{{plan.end | moment_date}}</p>
                            </div>
                            <div class="w-35">
                                <input v-if="editPlanId===plan.id" type="text" v-model="editPlan.days" maxlength="7">
                                <p v-else>{{plan.days}}</p>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex m-2">
                        <router-link :to="{name: 'PageDetailList', params: {id: plan.id}}" class="mr-auto">
                            <button class="btn btn-success">詳細ページ</button>
                        </router-link>
                        <button class="btn btn-info rounded-circle m-auto" v-if="editPlanId!==plan.id" @click="openEditInput(plan.id)">
                            <font-awesome-icon icon="edit" />
                        </button>
                        <button class="btn btn-danger rounded-circle m-auto" v-if="editPlanId!==plan.id" @click="deletePlan(plan.id)">
                            <font-awesome-icon icon="trash" />
                        </button>
                        <button class="btn btn-info rounded-circle m-auto" v-if="editPlanId===plan.id" @click="updatePlan(plan.id)">
                            <font-awesome-icon icon="check" />
                        </button>
                        <button class="btn btn-secondary rounded-circle m-auto" v-if="editPlanId===plan.id" @click="getPlans()">
                            ー
                        </button>
                        <router-link :to="{name: 'PageOutlineList', params: {id: plan.id}}" class="ml-auto">
                            <button class="btn btn-primary">概要ページ</button>
                        </router-link>
                    </div>
                </div>
            </div>
        </div>
        <plan-new :getPlans="getPlans" />
    </main>
</template>

<script>
import axios from 'axios'
import moment from 'moment'
import { AppSpinner } from '../parts'
import PlanNew from './PlanNew'
export default {
    components: { AppSpinner, PlanNew },
    data () {
        return {
            plans: [],
            newPlan: {},
            editPlan: {},
            editPlanId: -1,
            isInputOpen: false,
            isLoading: true
        }
    },
    filters: {
        moment_date (date) {
            if (date === null) {
                return "- / -"
            } else {
                return moment(date).format("MM / DD")
            }
        }
    },
    mounted () {
        this.getPlans()
    },
    methods: {
        getPlans () {
            axios
            .get(`/api/plans.json`, {
                headers: { 'Authorization': this.$cookies.get('usertoken') }
            })
            .then(response => {
                this.plans = response.data
                this.isLoading = false
                this.editPlanId = -1
            })
        },
        openEditInput (plan_id) {
            for (var plan of this.plans) {
                if (plan.id === plan_id) {
                    this.editPlan = plan
                    this.editPlanId = plan_id
                }
            }
        },
        updatePlan (plan_id) {
            const res = window.confirm("こちらの内容で更新しますか？")
            if (!res) {
                return false
            } else {
                if (this.editPlan.name === "") {
                    alert("プラン名がありません。")
                } else {
                    axios
                    .put(`/api/plans/${plan_id}`, this.editPlan, {
                        headers: { 'Authorization': this.$cookies.get('usertoken') }
                    })
                    .then(() => {
                        this.editPlanId = -1
                        this.getPlans()
                        window.scrollTo({ top: 0 })
                    })
                }
            }
        },
        deletePlan (plan_id) {
            const res = window.confirm("こちらのプランを削除しますか？")
            if (!res) {
                return false
            } else {
                axios
                .delete(`/api/plans/${plan_id}`, {
                    headers: { 'Authorization': this.$cookies.get('usertoken') }
                })
                .then(() => {
                    this.getPlans()
                })
            }
        }
    }
}
</script>

<style scoped>
h3, p {
    margin: 10px 5px;
    overflow: hidden;
}
input {
    width: 100%;
    height: 100%;
}
.main--planInfo {
    border: 5px solid gainsboro;
    text-align: center;
}
.plan__content-header {
    width: 50%;
    height: 35px;
    margin: auto;
    border: 10px solid blanchedalmond;
    border-bottom: 0;
}
.plan__content-main {
    background: floralwhite;
    box-shadow: 0 2px 2px;
    border: 10px solid blanchedalmond;
    border-radius: 10px;
}
.w-35 {
    width: 35%;
}
</style>
