<template>
    <div>
        <button-circle class="btn-secondary btn-sm" label="？" :clickFunction="() => showModal()" />
        <modal name="modal--appExplanation">
            <section class="px-5">
                <h3 class="text-info">★How to Use★</h3>
                <div v-if="isPagePlanList">
                    <img class="w-100" src="../../images/PagePlanList.png" alt="解説画像">
                </div>
                <div v-if="isPageOutlineList">
                    <img class="w-100" src="../../images/PageOutlineList.png" alt="解説画像">
                </div>
                <div v-if="isPageDetailList">
                    <img class="w-100" src="../../images/PageDetailList.png" alt="解説画像">
                </div>
            </section>
        </modal>
    </div>
</template>

<script>
import { ButtonCircle } from '../parts'

export default {
    components: { ButtonCircle },

    props: {
        isPagePlanList: false,
        isPageOutlineList: false,
        isPageDetailList: false
    },
    
    methods: {
        showModal() {
            this.$modal.show("modal--appExplanation")
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