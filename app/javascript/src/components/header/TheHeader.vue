<template>
    <header id="header">
        <slot name="pageName" />
        <span class="menu__block">
            <user-info />
            <app-explanation :isPagePlanList="isPagePlanList" :isPageOutlineList="isPageOutlineList" :isPageDetailList="isPageDetailList" />
        </span>
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
    background: mistyrose;
    border-bottom: 5px solid gainsboro;
}
.menu__block {
    position: relative;
    margin-left: auto;
    padding: 5px 10px;
    background: aliceblue;
    border-left: 5px solid gainsboro;
    text-align: center;
}
</style>