<template>
  <div class="table-content">
    <div class="cards-stack">
      <Card class="cards-stack__card" v-for="card in cardsList" v-bind:key="card" :cardName="card" />
    </div>
    <Hand @cardPlayed="putOnTable($event)" :cards="playerCards" />
  </div>
</template>


<script lang="ts">
import Hand from "../hand/Hand.vue";
import Card from "../hand/Card.vue";
import { Component, Vue } from "vue-property-decorator";
import { socket } from "../../centralSocket";

interface JoinedRoomData {
  hand: string[];
}

@Component({
  components: {
    Hand,
    Card,
  },
})
export default class Table extends Vue {
  cardsList = ["cAD"];
  playerCards: string[] = [];

  mounted() {
    socket.emit("joinRoom", { name: "Gdx", room: "testRoom" });
    socket.on("joinedRoom", (message: JoinedRoomData) => {
      this.playerCards = message.hand;
    });
  }

  putOnTable(cardName: string) {
    this.cardsList.push(cardName);
  }
}
</script>

<style lang="scss" scoped>
.cards-stack {
  display: flex;
}
</style>