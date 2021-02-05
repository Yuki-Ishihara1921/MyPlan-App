<template>
  <router-view />
</template>

<script>
import Vue from 'vue'

/* Vue Router */
import router from './router'

/* Vue Cookies */
import VueCookies from 'vue-cookies'
Vue.use(VueCookies)
Vue.$cookies.config('7d')

/* Vue Modal */
import VModal from 'vue-js-modal'
Vue.use(VModal)

/* Vue draggable */
import draggable from 'vuedraggable'
Vue.component('draggable', draggable)

/* Bootstrap */
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
Vue.use(BootstrapVue)

/* fontawesome */
import { library } from '@fortawesome/fontawesome-svg-core'
import { faUser, faUserCircle, faKey, faEdit, faCheck, faTrash, faTimesCircle } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
library.add(faUser, faUserCircle, faKey, faEdit, faCheck, faTrash, faTimesCircle)
Vue.component('font-awesome-icon', FontAwesomeIcon)

export default {
  router
}
</script>

<style>
body {
  background: snow;
}
.vm--modal {
  background: aliceblue;
}
/*
.vm--modal {
  top: 5% !important;
  left: 0 !important;
  height: auto !important;
  margin: 0 auto;
  padding: 2rem;
  background: aliceblue;
  border-radius: 10px;
}
.vm--modal h3 {
  text-align: center;
}
*/
</style>
