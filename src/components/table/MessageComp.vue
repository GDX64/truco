<template>
  <div class="message-content" :class="bShow?'': 'hidden'">
    <h3>{{boxText}}</h3>
  </div>
</template>


<script lang="ts">
import { Component, Vue, Prop } from "vue-property-decorator";

@Component({
  components: {},
})
export default class Table extends Vue {
  @Prop() private message!: string;
  bShow = false;

  get boxText() {
    this.bShow = true;
    setInterval(() => {
      this.bShow = false;
    }, 8000);
    return this.message;
  }
}
</script>

<style lang="scss" scoped>
.message-content {
  position: absolute;
  top: 0;
  right: 0;
  background-color: pink;
  border-radius: 10px;
  z-index: 1;
}
.hidden {
  display: none;
}
</style>