<template>
    <div>
        <the-header :isPageOutlines="isPageOutlines">
            <h1 slot="page-name" class="mx-3 my-auto text-primary">Plan Outlines</h1>
        </the-header>
        <outline-header :class="{'fixed-top': scrollY > headerY}" :plan="plan" />
        <app-spinner v-if="isLoading" />
        <div v-else class="pt-3 px-3">
            <outline-table :plan="plan" :isDraggable="isDraggable" :getPlan="getPlan" />
            <outline-buttons :plan="plan" :isDraggable="isDraggable" :changeIsDraggable="changeIsDraggable" />
        </div>
    </div>
</template>

<script>
import axios from 'axios'
import { TheHeader } from '../components/header'
import { AppSpinner } from '../components/parts'
import { OutlineHeader, OutlineTable, OutlineButtons } from '../components/plans/outlines'

export default {
    components: { AppSpinner, TheHeader, OutlineHeader, OutlineTable, OutlineButtons },
    data () {
        return {
            isPageOutlines: true,
            plan: {
                id: 0
            },
            headerY: 0,
            scrollY: 0,
            isLoading: true,
            isDraggable: false
        }
    },
    beforeCreate () {
        let jwt = this.$cookies.get('usertoken')
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
            axios
            .get(`/api/plans/${this.$route.params.id}.json`)
            .then(response => {
                this.plan = response.data
                this.isLoading = false
            })
        },
        handleScroll () {
            this.headerY = document.getElementById('header').clientHeight
            this.scrollY = window.scrollY
            var table = document.getElementById('table')
            const planname = document.getElementById('planname')
            if (this.scrollY > this.headerY) {
                const plannameY = planname.clientHeight
                table.style.marginTop = plannameY + 2 + 'px'
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
