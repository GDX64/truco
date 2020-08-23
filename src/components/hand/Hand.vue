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
import { socket } from "../../centralSocket";

@Component({
  components: {
    Card,
  },
})
export default class Hand extends Vue {
  @Prop() private msg!: string;
  @Prop() private cards!: string[];

  get cardsList() {
    return this.cards;
  }

  playCard(cardName: string) {
    console.log(cardName);
    socket.emit("playedCard", { card: cardName });
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
.hand {
  margin-top: 4rem;
}
.cards-container {
  display: flex;
  justify-content: flex-start;
  min-width: 50%;
  max-width: 400px;

  &__play-card {
    transition: all 0.2s;

    &:hover {
      transform: translateY(-1rem);
    }
  }
}
</style>
