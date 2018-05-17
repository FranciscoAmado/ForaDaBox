<template>
  <div id="app">
    <main class="vapor-app__content">
    <h1 class="t-center mt150">Fora da Box</h1>
    <vue-event-calendar 
      :events="list"
      :selectedDay=today>
      <template scope="props">
        <div v-for="(event, index) in props.showEvents" 
          class="event-item" 
          v-bind:key="event.id">
            <b-row class="my-2">
              <b-col><h2>{{event.time}} {{event.title}}</h2></b-col>
              <!-- <b-col><h4 align="right">Vagas disponíveis: {{ event.attendees.size }}/10</h4></b-col> -->
            </b-row>
            <b-row class="my-2">
              <b-col sm="9"><b-form-input v-model="text1" type="text" placeholder="Nome"></b-form-input></b-col>
              <b-col sm="3" align="center"><b-button v-on:click="handleSubmit(event,text1)">Inscrever</b-button></b-col>
            </b-row>
            <span v-if="event.attendees"><h4>Inscritos: </h4></span>
            <ul>
              <li v-for="attendee in event.attendees"
                  v-bind:key="attendee">
                <h5>{{ attendee }}</h5>
              </li>
            </ul>
        </div>
      </template>
    </vue-event-calendar>
    </main>
  </div>
</template>

<script>
  import { fetchEventList, updateEvent } from './api/api'

  require('./assets/styles/css/bootstrap.min.css');

  let today = new Date();

  export default {
    name: 'app',
    components: {},
    computed: {
      list() {
        console.log("computed.list");
        return this.$store.getters.getEventList;
      },
    },

    methods: {
      handleDayChanged (data) {
        console.log('date-changed', data);
      },
      handleMonthChanged (data) {
        console.log('month-changed', data);
      },
      handleSubmit (event, person) {
        const newEvent = event;
        newEvent.attendees.push(person);
        console.log('event', newEvent);
        updateEvent(newEvent, this.handleResponse);
      },
      handleResponse(resp) {
        if (resp.error) {
          console.log(resp.messages);
        } else {
          console.log("SUCCESS");
        }
      }
    },

    mounted () {
      fetchEventList();
      console.log("mounted");
    }
  }
</script>

<style lang="less">
  @import "assets/styles/css/min/base.less";
</style>
