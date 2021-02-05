<template>
    <header id="header">
        <slot name="page-name" />
        <span class="menu__block">
            <user-info />
            <app-explanation :isPagePlans="isPagePlans" :isPageOutlines="isPageOutlines" :isPageDetails="isPageDetails" />
        </span>
    </header>
</template>

<script>
import UserInfo from './UserInfo'
import AppExplanation from './AppExplanation'
export default {
    components: { UserInfo, AppExplanation },
    props: {
        isPagePlans: false,
        isPageOutlines: false,
        isPageDetails: false
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