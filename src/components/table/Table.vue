<template>
  <div class="table-content">
    <message-comp :message="message" />
    <h2 v-if="!turnEnded">É a vez de {{whoPlaysNow}}</h2>
    <h2 v-else>O turno acabou, comece outro</h2>
    <button class="start" @click="playRound">Play a Round!</button>
    <button class="end" @click="endTurn">End Turn</button>
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
    </div>
  </div>
</template>


<script lang="ts">
import Hand from "../hand/Hand.vue";
import Card from "../hand/Card.vue";
import MessageComp from "./MessageComp.vue";

import { Component, Vue } from "vue-property-decorator";
import { socket } from "../../centralSocket";

interface DataInfo {
  hand: string[];
  playersList: string[];
  table: string[];
  whoPlaysNow: string | undefined;
  turnEnded: boolean;
  message?: string;
}

@Component({
  components: {
    Hand,
    Card,
    MessageComp,
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
  message = "";

  mounted() {
    socket.on("updateInfo", (data: DataInfo) => {
      if (data.hand) this.playerCards = data.hand;
      this.cardsList = data.table;
      this.playersList = data.playersList;
      this.whoPlaysNow = data.whoPlaysNow ? data.whoPlaysNow : "ninguém";
      this.turnEnded = data.turnEnded;
      if (data.message) this.message = data.message;
      console.log(data);
    });

    socket.on("welcome", (data: { rooms: string[] }) => {
      console.log(data);
      this.rooms = data.rooms;
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
  min-width: 20%;
  max-width: 300px;
  margin-top: 20px;
}
.info-content {
  display: flex;
}

.name-input {
  display: block;
  margin-bottom: 10px;
}

.room-input {
  margin-right: 10px;
}

.all-rooms {
  margin-left: 10%;
}

button {
  cursor: pointer;
}
</style>