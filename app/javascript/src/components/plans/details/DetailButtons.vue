<template>
    <div>
        <div class="detailButton -sort">
            <button id="sort" class="btn btn-info btn-lg rounded-circle" @click="changeIsDraggable()" :class="{'btn-danger': isDraggable}">⇅</button>
        </div>
        <div class="detailButton -add">
            <button class="btn btn-success btn-lg rounded-circle" @click="createRow()">＋</button>
        </div>
    </div>
</template>

<script>
import axios from 'axios'

export default {
    props: {
        plan: {},
        isDraggable: false,
        changeIsDraggable: Function
    },

    methods: {
        createRow () {
            axios
            .post(`/api/plans/${this.$route.params.id}/details`)
            .then(response => {
                this.plan.details.push(response.data)
                this.moveBottom()
            })
        },
        
        moveBottom () {
            var element = document.documentElement
            var bottom = element.scrollHeight - element.clientHeight
            window.scroll(0, bottom)
        }
    }
}
</script>

<style lang='scss' scoped>
.detailButton {
    position: fixed;
    bottom: 10px;
    &.-sort {
        left: 20px;
    }
    &.-add {
        right: 20px;
    }
}
</style>