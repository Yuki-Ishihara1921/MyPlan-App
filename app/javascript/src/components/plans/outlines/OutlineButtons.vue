<template>
    <div>
        <button
            class="outlineButton -sort btn btn-info btn-lg rounded-circle"
            id="sort" @click="changeIsDraggable()" :class="{'btn-danger': isDraggable}"    
        >
            ⇅
        </button>
        <button
            class="outlineButton -add btn btn-primary btn-lg rounded-circle"
            @click="createRow()"
        >
            ＋
        </button>
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
            .post(`/api/plans/${this.$route.params.id}/outlines`)
            .then(response => {
                this.plan.outlines.push(response.data)
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
.outlineButton {
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