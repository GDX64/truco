<template>
  <div class="table-content">
    <h2 v-if="!turnEnded">É a vez de {{whoPlaysNow}}</h2>
    <h2 v-else>O turno acabou, comece outro</h2>
    <div class="cards-stack">
      <Card class="cards-stack__card" v-for="card in cardsList" v-bind:key="card" :cardName="card" />
    </div>
    <Hand :cards="playerCards" />
    <div class="administration-container">
      <input type="text" class="name-input" placeholder="Player name" v-model="playerName" />
      <input type="text" class="room-input" placeholder="Room name" v-model="roomName" />
      <button class="join-room-btn" @click="joinRoom">JOIN!</button>
      <div class="info-content">
        <div class="this-room">
          <h2 class>All players in this room</h2>
          <ul class="players-list">
            <li v-for="player in playersList" :key="player">{{player}}</li>
          </ul>
        </div>
        <div class="all-rooms">
          <h2 class>All rooms</h2>
          <ul class="rooms-list">
            <li v-for="room in rooms" :key="room">{{room}}</li>
          </ul>
        </div>
      </div>
      <button class="start" @click="playRound">Play a Round!</button>
      <button class="end" @click="endTurn">End Turn</button>
    </div>
  </div>
</template>


<script lang="ts">
import Hand from "../hand/Hand.vue";
import Card from "../hand/Card.vue";
import { Component, Vue } from "vue-property-decorator";
import { socket } from "../../centralSocket";

interface DataInfo {
  hand: string[];
  playersList: string[];
  table: string[];
  whoPlaysNow: string | undefined;
  turnEnded: boolean;
}

@Component({
  components: {
    Hand,
    Card,
  },
})
export default class Table extends Vue {
  cardsList: string[] = [];
  playerCards: string[] = [];
  playerName = "";
  roomName = "";
  playersList: string[] = [];
  rooms: string[] = [];
  whoPlaysNow = "";
  turnEnded = false;

  mounted() {
    socket.on("updateInfo", (message: DataInfo) => {
      if (message.hand) this.playerCards = message.hand;
      this.cardsList = message.table;
      this.playersList = message.playersList;
      this.whoPlaysNow = message.whoPlaysNow ? message.whoPlaysNow : ":(";
      this.turnEnded = message.turnEnded;
      console.log(message);
    });

    socket.on("welcome", (message: { rooms: string[] }) => {
      console.log(message);
      this.rooms = message.rooms;
      socket.emit("thanks", "thank you");
    });
  }

  playRound() {
    socket.emit("playRound", { name: this.playerName });
  }

  joinRoom() {
    socket.emit("joinRoom", { name: this.playerName, room: this.roomName });
  }

  endTurn() {
    socket.emit("endTurn", { name: this.playerName });
  }
}
</script>

<style lang="scss" scoped>
.cards-stack {
  display: flex;
}
.info-content {
  display: flex;
}

.all-rooms {
  margin-left: 10%;
}
</style>