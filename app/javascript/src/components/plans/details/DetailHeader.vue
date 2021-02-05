<template>
    <div id="planname" class="planname__block">
        <router-link to="/" class="ml-0 my-auto px-1">
            <button class="btn btn-secondary">←TOP</button>
        </router-link>
        <h4 class="w-75 m-auto py-3 border-left border-right">{{plan.name}}</h4>
        <h5 class="w-25 m-auto py-3 border-right">
            <span>{{plan.start | moment_date}}</span>
            <span>~</span>
            <span>{{plan.end | moment_date}}</span>
        </h5>
        <router-link :to="{name: 'PageOutlineList', params: {id: plan.id}}" class="mr-0 my-auto px-1">
            <button class="btn btn-primary"><span>概要→</span></button>
        </router-link>
    </div>
</template>

<script>
import moment from 'moment'
export default {
    props: {
        plan: {}
    },
    filters: {
        moment_date (date) {
            if (date === null) {
                return "- / -"
            } else {
                return moment(date).format("MM / DD")
            }
        }
    }
}
</script>

<style scoped>
span {
    white-space: pre;
}
.planname__block {
    display: flex;
    background: lemonchiffon;
    border-bottom: 5px solid gainsboro;
    text-align: center;
}
</style>