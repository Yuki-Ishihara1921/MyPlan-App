<template>
    <div class="pageOutlineList">
        <the-header :isPageOutlineList="isPageOutlineList">
            <h1 slot="pageName" class="mx-3 my-auto text-primary">Plan Outlines</h1>
        </the-header>
        <main>
            <outline-header :class="{'fixed-top': scrollY > headerY}" :plan="plan" />
            <div class="pt-3 px-3">
                <outline-table :plan="plan" :isDraggable="isDraggable" :getPlan="getPlan" />
                <outline-buttons :plan="plan" :isDraggable="isDraggable" :changeIsDraggable="changeIsDraggable" />
            </div>
        </main>
        <app-loading v-if="isLoading" text="データ取得中..." />
    </div>
</template>

<script>
import axios from 'axios'
import { TheHeader } from '../components/header'
import { OutlineHeader, OutlineTable, OutlineButtons } from '../components/plans/outlines'
import { AppLoading } from '../components/parts'

export default {
    components: { TheHeader, OutlineHeader, OutlineTable, OutlineButtons, AppLoading },

    data () {
        return {
            plan: {},
            headerY: 0,
            scrollY: 0,
            isLoading: false,
            isDraggable: false,
            isPageOutlineList: true,
        }
    },

    beforeCreate () {
        const jwt = this.$cookies.get('usertoken')
        if (!jwt) {
            this.$router.push({ name: 'PageAuth' })
        }
    },

    mounted () {
        this.getPlan()
        window.addEventListener('scroll', this.handleScroll)
    },

    destroyed () {
        window.removeEventListener('scroll', this.handleScroll)
    },

    methods: {
        getPlan () {
            this.isLoading = true
            axios
            .get(`/api/plans/${this.$route.params.id}.json`)
            .then(response => {
                console.log("data", response.data)
                this.plan = response.data
                this.isLoading = false
            })
        },

        handleScroll () {
            this.headerY = document.getElementById('header').clientHeight
            this.scrollY = window.scrollY
            const table = document.getElementById('table')
            const outlineHeader = document.getElementById('outlineHeader')
            if (this.scrollY > this.headerY) {
                const outlineHeaderY = outlineHeader.clientHeight
                table.style.marginTop = outlineHeaderY + 2 + 'px'
            } else if (table) {
                table.style.marginTop = 0
            }
        },

        changeIsDraggable () {
            this.isDraggable = !this.isDraggable
        }
    }
}
</script>

<style scoped>
.pageOutlineList {
    min-width: 850px;
}
</style>