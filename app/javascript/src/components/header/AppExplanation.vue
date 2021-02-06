<template>
    <span>
        <button class="btn btn-secondary rounded-circle" @click="showModal()">？</button>
        <modal name="modal--appExplanation">
            <section class="px-5">
                <h3 class="text-info">★How to Use★</h3>
                <div v-if="isPagePlanList">
                    <img class="w-100" src="../../images/PagePlanList.png" alt="プラン一覧">
                </div>
                <div v-if="isPageOutlineList">
                    <img class="w-100" src="../../images/PageOutlineList.png" alt="アウトライン一覧">
                </div>
                <div v-if="isPageDetailList">
                    <img class="w-100" src="../../images/PageDetailList.png" alt="ディテイル一覧">
                </div>
            </section>
        </modal>
    </span>
</template>

<script>
export default {
    props: {
        isPagePlanList: false,
        isPageOutlineList: false,
        isPageDetailList: false
    },
    
    methods: {
        showModal() {
            this.$modal.show("modal--appExplanation")
        },

        hideModal() {
            this.$modal.hide("modal--appExplanation")
        }
    }
}
</script>

<style scoped>
.vm--modal {
    top: 100px !important;
    height: auto !important;
}
</style>