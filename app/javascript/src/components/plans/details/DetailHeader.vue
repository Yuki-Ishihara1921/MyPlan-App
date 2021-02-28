<template>
    <div id="detailHeader">
        <router-link :to="{name: 'PagePlanList'}" class="ml-0 my-auto p-2 border-right">
            <button class="btn btn-secondary">← TOP</button>
        </router-link>
        <h4 class="m-auto p-2">{{plan.name}}</h4>
        <h5 class="my-auto p-2 border-left">
            <span>{{plan.start | moment_date}}</span>
            <span>~</span>
            <span>{{plan.end | moment_date}}</span>
        </h5>
        <router-link :to="{name: 'PageOutlineList', params: {id: plan.id}}" class="mx-0 my-auto p-2 border-left">
            <button class="btn btn-primary">概要 →</button>
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
#detailHeader {
    display: flex;
    background: lemonchiffon;
    border-bottom: 5px solid gainsboro;
    text-align: center;
}

button {
    width: 80px;
}
</style>