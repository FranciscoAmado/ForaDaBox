<template>
  <div id="app">
    <main class="vapor-app__content">
    <h1 class="t-center mt150">Fora da Box</h1>
    <vue-event-calendar 
      :events="list"
      :selectedDay=today>
      <!-- <template scope="props">
        <slot>
          <div v-for="(event, index) in events" class="event-item">
            <cal-event-item :event="event" :index="index" :locale="locale"></cal-event-item>
          </div>
        </slot>
      </template> -->
      <template scope="props">
        <div v-for="(event, index) in props.showEvents" class="event-item">
          <!-- In here do whatever you want, make you owner event template -->
          <!-- {{event}} -->
          <!-- <div class="wrapper"> -->
            <!-- <p class="time">{{dateTimeFormatter(Date.parse(new Date(event.date)),i18n[locale].fullFormat)}}</p> -->
            <!-- <p class="desc">{{event.desc}}</p> -->
          <!-- </div> -->
          <!-- <b-container fluid> -->
            <b-row class="my-1">
              <b-col><h2>{{event.time}} {{event.title}}</h2></b-col>
              <b-col><h4 align="right">Vagas disponíveis: 8/10</h4></b-col>
            </b-row>
            <b-row class="my-1">
              <b-col sm="9"><b-form-input v-model="text1" type="text" placeholder="Nome"></b-form-input></b-col>
              <b-col sm="3" align="center"><b-button href="#">Inscrever</b-button></b-col>
            </b-row>
            <h4>Inscritos: </h4>
            <h5>- Francisco Amado </h5>
          <!-- </b-container> -->
        </div>
      </template>
    </vue-event-calendar>
    </main>
  </div>
</template>

<script>
  import {fetchEventList} from './api/api'

  require('./assets/styles/css/bootstrap.min.css');

  let today = new Date()

  export default {
    name: 'app',
    components: {},
    data () {
      return {}
    },

    computed: {
      list() {
        console.log("getEventList  " +this.$store.getters.getEventList);
        return this.$store.getters.getEventList;
      },
    },

    methods: {
      handleDayChanged (data) {
        console.log('date-changed', data)
      },
      handleMonthChanged (data) {
        console.log('month-changed', data)
      }
    },
    
    mounted () {
      fetchEventList();
    }
  }
</script>

<style lang="less">
  @import "assets/styles/css/min/base.less";
</style>
