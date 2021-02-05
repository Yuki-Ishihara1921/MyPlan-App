<template>
    <div>
        <the-header :isPageDetailList="isPageDetailList">
            <h1 slot="pageName" class="mx-3 my-auto text-success">Plan Details</h1>
        </the-header>
        <main>
            <detail-header :class="{'fixed-top': scrollY > headerY}" :plan="plan" />
            <app-spinner v-if="isLoading" />
            <div v-else class="pt-3 px-3">
                <detail-table :plan="plan" :isDraggable="isDraggable" :getPlan="getPlan" />
                <detail-buttons :plan="plan" :isDraggable="isDraggable" :changeIsDraggable="changeIsDraggable" />
            </div>
        </main>
    </div>
</template>

<script>
import axios from 'axios'
import { TheHeader } from '../components/header'
import { AppSpinner } from '../components/parts'
import { DetailHeader, DetailTable, DetailButtons } from '../components/plans/details'

export default {
    components: { TheHeader, AppSpinner, DetailHeader, DetailTable, DetailButtons },

    data () {
        return {
            plan: {},
            headerY: 0,
            scrollY: 0,
            isLoading: true,
            isDraggable: false,
            isPageDetailList: true,
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
            const detailHeader = document.getElementById('detailHeader')
            if (this.scrollY > this.headerY) {
                const detailHeaderY = detailHeader.clientHeight
                table.style.marginTop = detailHeaderY + 2 + 'px'
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
