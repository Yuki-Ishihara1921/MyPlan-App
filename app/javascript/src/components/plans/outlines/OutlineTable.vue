<template>
    <table id="table" class="table table-bordered table-outlines" :class="{'draggable': isDraggable}">
        <thead class="thead-light text-center">
            <div>
                <tr>
                    <th class="w-datetime" scope="col">日付</th>
                    <th class="w-datetime" scope="col">時間</th>
                    <th class="w-schedule" cope="col">スケジュール</th>
                    <th class="w-note" scope="col">メモ</th>
                    <th class="w-delete" scope="col">消</th>
                </tr>
            </div>
        </thead>
        <tbody>
            <draggable v-model="plan.outlines" @end="sortTable()" :disabled="!isDraggable" animation="200">
                <tr class="bg-white" v-for="outline in plan.outlines" v-bind:key="outline.id">
                    <td class="w-datetime" @dblclick="openInputField(outline.id, 0)">
                        <input v-if="editRowId===outline.id && editColumnId===0" v-model="editOutline.date" @blur="updateField(outline.id)">
                        <p v-else>{{outline.date}}</p>
                    </td>
                    <td class="w-datetime" @dblclick="openInputField(outline.id, 1)">
                        <input v-if="editRowId===outline.id && editColumnId===1" v-model="editOutline.time" @blur="updateField(outline.id)">
                        <p v-else>{{outline.time}}</p>
                    </td>
                    <td class="w-schedule" @dblclick="openInputField(outline.id, 2)">
                        <textarea v-if="editRowId===outline.id && editColumnId===2" v-model="editOutline.schedule" @blur="updateField(outline.id)" />
                        <p v-else>{{outline.schedule}}</p>
                    </td>
                    <td class="w-note" @dblclick="openInputField(outline.id, 3)">
                        <textarea v-if="editRowId===outline.id && editColumnId===3" v-model="editOutline.note" @blur="updateField(outline.id)" />
                        <p v-else>{{outline.note}}</p>
                    </td>
                    <td class="w-delete">
                        <font-awesome-icon icon="times-circle" class="icon-times-style text-danger" @click="deleteRow(outline.id)" />
                    </td>
                </tr>
            </draggable>
        </tbody>
    </table>
</template>

<script>
import axios from 'axios'
import moment from 'moment'
export default {
    data () {
        return {
            editOutline: {
                date: "",
                time: "",
                schedule: "",
                note: ""
            },
            editRowId: -1,
            editColumnId: -1
        }
    },
    props: {
        plan: {
            outlines: []
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
            for (var outline of this.plan.outlines) {
                if (outline.id === id) {
                    this.editOutline = outline
                }
            }
            this.editRowId = id
            this.editColumnId = column_id
        },
        updateField (id) {
            axios
            .put(`/api/plans/${this.$route.params.id}/outlines/${id}`, this.editOutline)
            .then(() => {
                this.editRowId = -1
                this.editColumnId = -1
                this.getPlan()
            })
            .catch((error) => {
                alert("更新できませんでした。通信環境をご確認下さい。")
                throw new Error(error)
            })
        },
        deleteRow (id) {
            const res = window.confirm("こちらのラインを削除しますか？")
            if (!res) {
                return false
            } else {
                axios
                .delete(`/api/plans/${this.$route.params.id}/outlines/${id}`)
                .then(() => { this.getPlan() })
                .catch((error) => {
                    alert("削除できませんでした。もう一度やり直して下さい。")
                    throw new Error(error)
                })
            }
        },

        sortTable () {
            axios
            .patch(`/api/plans/${this.$route.params.id}/outlines`, {
                outlines: this.plan.outlines
            })
            .catch((error) => {
                alert("並び替えできませんでした。通信環境をご確認下さい。")
                throw new Error(error)
            })
        }
    }
}
</script>

<style scoped>
.draggable {
    border: 5px solid red !important;
}
.draggable tbody {
    cursor: move;
}
.draggable tr:hover {
    background: aliceblue !important;
}
.icon-times-style {
    cursor: pointer;
}
input, textarea {
    width: 100%;
}
p {
    margin: 0;
    white-space: pre-wrap;
}
.table {
    max-width: 800px;
    margin: auto;
    margin-bottom: 8rem;
}
.table td {
    vertical-align: middle;
}
.table-outlines {
    border: 5px solid aqua;
}
.w-datetime {
    width: 90px;
    text-align: center;
    font-weight: bold;
}
.w-schedule {
    width: 330px;
}
.w-note {
    width: 250px;
}
.w-delete {
    width: 30px;
    text-align: center;
}
</style>