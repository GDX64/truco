<template>
  <div class="hello">
    <div class="single-card" v-html="cardToShow" @click="$emit('cardSelected', cardName)"></div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from "vue-property-decorator";
import svgDict from "./svgsDict";
import { socket } from "../../centralSocket";

//console.log(svgDict);

@Component({
  components: {},
})
export default class Hand extends Vue {
  @Prop() private cardName!: string;
  get cardToShow() {
    return svgDict[this.cardName];
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss">
.single-card {
  svg {
    width: 10rem;
    height: auto;
    transition: all 0.2s;
    cursor: pointer;
  }
  svg:hover {
    transform: translateY(-1rem);
  }
}
</style>
