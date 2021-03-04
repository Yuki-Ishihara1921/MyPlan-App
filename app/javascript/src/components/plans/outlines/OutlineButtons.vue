<template>
    <div>
        <button-circle
            :class="isDraggable ? 'outlineButton -sort btn-danger btn-lg' : 'outlineButton -sort btn-info btn-lg'"
            label="⇅" :clickFunction="() => changeIsDraggable()"
        />
        <button-circle
            class="outlineButton -add btn-success btn-lg"
            label="＋" :clickFunction="() => createRow()"
        />
    </div>
</template>

<script>
import axios from 'axios'
import { ButtonCircle } from '../../parts'

export default {
    components: { ButtonCircle },

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