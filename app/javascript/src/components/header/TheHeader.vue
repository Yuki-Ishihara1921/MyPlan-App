<template>
    <header id="header">
        <slot name="pageName" />
        <div class="header__menu d-flex">
            <user-info />
            <app-explanation
                :isPagePlanList="isPagePlanList"
                :isPageOutlineList="isPageOutlineList"
                :isPageDetailList="isPageDetailList"
            />
        </div>
    </header>
</template>

<script>
import UserInfo from './UserInfo'
import AppExplanation from './AppExplanation'

export default {
    components: { UserInfo, AppExplanation },

    props: {
        isPagePlanList: false,
        isPageOutlineList: false,
        isPageDetailList: false
    }
}
</script>

<style scoped>
header {
    display: flex !important;
    border-bottom: 5px solid gainsboro;
    background: mistyrose;
}
.header__menu {
    position: relative;
    display: flex;
    margin-left: auto;
    padding: 0.5rem;
    border-left: 5px solid gainsboro;
    background: aliceblue;
    text-align: center;
}
</style>