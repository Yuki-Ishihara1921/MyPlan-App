<template>
    <span>
        <button class="btn btn-secondary rounded-circle" @click="showModal()">？</button>
        <modal name="modal-AppExplanation">
            <h3 class="text-info">★How to Use★</h3>
            <div v-if="isPagePlans">
                <img class="w-100" src="../../images/PagePlanList.png" alt="プラン一覧">
            </div>
            <div v-if="isPageOutlines">
                <img class="w-100" src="../../images/PageOutlineList.png" alt="アウトライン一覧">
            </div>
            <div v-if="isPageDetails">
                <img class="w-100" src="../../images/PageDetailList.png" alt="ディテイル一覧">
            </div>
            <button class="btn btn-secondary w-25 mt-2" @click="hideModal()">戻る</button>
        </modal>
    </span>
</template>

<script>
export default {
    props: {
        isPagePlans: false,
        isPageOutlines: false,
        isPageDetails: false
    },
    
    methods: {
        showModal() {
            this.$modal.show("modal-AppExplanation")
        },
        hideModal() {
            this.$modal.hide("modal-AppExplanation")
        }
    }
}
</script>