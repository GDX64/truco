<template>
  <div id="app">
    <Table />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import Table from "./components/table/Table.vue";

@Component({
  components: {
    Table,
  },
})
export default class App extends Vue {}
</script>

<style lang="scss">
</style>
