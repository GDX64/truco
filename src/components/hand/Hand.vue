<template>
  <div class="hand">
    <div class="cards-container">
      <Card
        class="cards-container__play-card"
        v-for="card in cardsList"
        v-bind:key="card"
        :cardName="card"
        @cardSelected="playCard($event)"
      />
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from "vue-property-decorator";
import Card from "./Card.vue";

@Component({
  components: {
    Card,
  },
})
export default class Hand extends Vue {
  @Prop() private msg!: string;
  cardsList = ["c4D", "cKS", "cTH"];

  playCard(cardName: string) {
    console.log(cardName);
    this.cardsList = this.cardsList.filter((item) => item !== cardName);
    this.$emit("cardPlayed", cardName);
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
.hand {
  margin-top: 10rem;
}
.cards-container {
  display: flex;
}
</style>
