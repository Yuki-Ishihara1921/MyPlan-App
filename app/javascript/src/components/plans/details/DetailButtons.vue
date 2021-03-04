<template>
    <div>
        <button-circle
            :class="isDraggable ? 'detailButton -sort btn-danger btn-lg' : 'detailButton -sort btn-info btn-lg'"
            label="⇅" :clickFunction="() => changeIsDraggable()"
        />
        <button-circle
            class="detailButton -add btn-success btn-lg"
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