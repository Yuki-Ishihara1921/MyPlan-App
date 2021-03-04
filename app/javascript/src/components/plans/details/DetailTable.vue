<template>
    <table id="table" class="table table-bordered table-sm detailTable" :class="{'draggable': isDraggable }">
        <thead class="thead-light text-center">
            <div>
                <tr>
                    <th class="detailTable-datetime" scope="col">日付</th>
                    <th class="detailTable-datetime" scope="col">時間</th>
                    <th class="detailTable-schedule" cope="col">スケジュール</th>
                    <th class="detailTable-note" scope="col">メモ</th>
                    <th class="detailTable-delete" scope="col">
                        <font-awesome-icon
                            icon="trash" class="w-100"
                        />
                    </th>
                </tr>
            </div>
        </thead>
        <tbody>
            <draggable v-model="plan.details" @end="sortTable()" :disabled="!isDraggable" animation="200">
                <tr class="bg-white" v-for="detail in plan.details" :key="detail.id">
                    <td class="detailTable-datetime" @dblclick="openInputField(detail.id, 0)">
                        <input
                            v-if="editRowId===detail.id && editColumnId===0"
                            v-model="editDetail.date" @blur="updateField(detail.id)"
                        >
                        <p v-else>{{detail.date}}</p>
                    </td>
                    <td class="detailTable-datetime" @dblclick="openInputField(detail.id, 1)">
                        <input
                            v-if="editRowId===detail.id && editColumnId===1" type="time"
                            v-model="editDetail.time" @blur="updateField(detail.id)"
                        >
                        <p v-else>{{detail.time | moment_time}}</p>
                    </td>
                    <td class="detailTable-schedule px-2" @dblclick="openInputField(detail.id, 2)">
                        <textarea
                            v-if="editRowId===detail.id && editColumnId===2"
                            v-model="editDetail.schedule" @blur="updateField(detail.id)"
                        />
                        <p v-else>{{detail.schedule}}</p>
                    </td>
                    <td class="detailTable-note px-2" @dblclick="openInputField(detail.id, 3)">
                        <textarea
                            v-if="editRowId===detail.id && editColumnId===3"
                            v-model="editDetail.note" @blur="updateField(detail.id)"
                        />
                        <p v-else>{{detail.note}}</p>
                    </td>
                    <td class="detailTable-delete">
                        <font-awesome-icon
                            icon="times-circle" class="icon-times-style text-danger"
                            @click="deleteRow(detail.id)"
                        />
                    </td>
                </tr>
            </draggable>
        </tbody>
        <app-loading v-if="isLoading" :text="loadingText" />
    </table>
</template>

<script>
import axios from 'axios'
import moment from 'moment'
import { AppLoading } from '../../parts'

export default {
    components: {
        AppLoading
    },

    data () {
        return {
            editDetail: {
                date: "",
                time: "",
                schedule: "",
                note: ""
            },
            editRowId: -1,
            editColumnId: -1,
            isLoading: false,
            loadingText: ""
        }
    },

    props: {
        plan: {
            details: []
        },
        isDraggable: false,
        getPlan: Function
    },

    filters: {
        moment_time (time) {
            if (time === null) {
                return "- : -"
            } else {
                return moment(time).format("HH : mm")
            }
        }
    },

    methods: {
        openInputField (id, column_id) {
            for (var detail of this.plan.details) {
                if (detail.id === id) {
                    this.editDetail = detail
                }
            }
            this.editRowId = id
            this.editColumnId = column_id
        },

        updateField (id) {
            this.isLoading = true
            this.loadingText = "更新中..."
            axios
            .put(`/api/plans/${this.$route.params.id}/details/${id}`, this.editDetail)
            .then(() => {
                this.editRowId = -1
                this.editColumnId = -1
                this.hideLoading()
                this.getPlan()
            })
            .catch((error) => {
                alert("更新できませんでした。通信環境をご確認下さい。")
                throw new Error(error)
            })
        },

        deleteRow (id) {
            this.loadingText = "削除中..."
            const res = window.confirm("こちらのラインを削除しますか？")
            if (!res) {
                return false
            } else {
                this.isLoading = true
                axios
                .delete(`/api/plans/${this.$route.params.id}/details/${id}`)
                .then(() => {
                    this.hideLoading()
                    this.getPlan()
                })
                .catch((error) => {
                    alert("削除できませんでした。もう一度やり直して下さい。")
                    this.hideLoading()
                    throw new Error(error)
                })
            }
        },

        sortTable () {
            this.isLoading = true
            this.hideLoading = "更新中..."
            axios
            .patch(`/api/plans/${this.$route.params.id}/details`, {
                details: this.plan.details
            })
            .then(() => {
                this.hideLoading()
            })
            .catch((error) => {
                alert("並び替えできませんでした。通信環境をご確認下さい。")
                this.hideLoading()
                throw new Error(error)
            })
        },

        hideLoading () {
            this.loadingText = ""
            this.isLoading = false
        }
    }
}
</script>

<style lang='scss' scoped>
.icon-times-style {
    cursor: pointer;
}

.detailTable {
    border: 5px solid aquamarine;
    &-datetime {
        min-width: 75px;
        text-align: center;
        font-weight: bold;
    }
    &-schedule {
        min-width: 362px;
    }
    &-note {
        min-width: 250px;
    }
    &-delete {
        text-align: center;
    }
}

.draggable {
    border: 5px solid red !important;
    & tbody {
        cursor: move;
    }
    & tr:hover {
        background: aliceblue !important;
    }
}

.table {
    max-width: 800px;
    margin: auto;
    margin-bottom: 8rem;
    & thead th {
        vertical-align: middle;
    }
    & td {
        vertical-align: middle;
    }
}

input, textarea {
    width: 100%;
}

p {
    margin: 0;
    word-break: break-word;
    white-space: break-spaces;
}
</style>