<template>
  <div id="app">
    <main class="vapor-app__content">
    <h1 class="t-center mt150">Fora da Box</h1>
    <vue-event-calendar :events="demoEvents">
      <template scope="props">
        <slot>
          <div v-for="(event, index) in events" class="event-item">
            <cal-event-item :event="event" :index="index" :locale="locale"></cal-event-item>
          </div>
        </slot>
      </template>
    </vue-event-calendar>
    </main>
  </div>
</template>

<script>
  require('./assets/styles/css/bootstrap.min.css');
  
  let today = new Date()

  export default {
    name: 'app',
    components: {},
    data () {
      return {
        demoEvents: [{
            date: `${today.getFullYear()}/${today.getMonth() + 1}/15`,
            title: 'WOD',
            time: '07h15',
            desc: 'Chico; Nielsen; Gina'
        },{
            date: `${today.getFullYear()}/${today.getMonth() + 1}/24`,
            title: 'Alongamentos',
            time: '18h00',
            desc: 'longlonglong description'
        },{
            date: `${today.getFullYear()}/${today.getMonth() + 1}/24`,
            title: 'WOD',
            time: '18h45',
            desc: 'longlonglong description'
        },{
            date: `${today.getFullYear()}/${today.getMonth() === 11 ? 1 : today.getMonth() + 2}/06`,
            title: 'WOD',
            time: '20h15',
            desc: 'longlonglong description'
        }]
      }
    },
    methods: {
      handleDayChanged (data) {
        console.log('date-changed', data)
      },
      handleMonthChanged (data) {
        console.log('month-changed', data)
      }
    }
  }
</script>

<style lang="less">
  @import "assets/styles/css/min/base.less";
</style>
