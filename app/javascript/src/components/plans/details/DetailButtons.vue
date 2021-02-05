<template>
    <div>
        <div class="button-fixed--sort">
            <button id="sort" class="btn btn-info btn-lg rounded-circle" @click="changeIsDraggable()" :class="{'btn-danger': isDraggable}">⇅</button>
        </div>
        <div class="button-fixed--add">
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

<style>
.button-fixed--add {
  position: fixed;
  right: 20px;
  bottom: 10px;
}
.button-fixed--sort {
  position: fixed;
  left: 20px;
  bottom: 10px;
}
</style>