<template>
  <v-row>
    <v-col sm="3">
      <v-select
        solo
        label="Vehicle"
        :items="vehicles"
        return-object
        item-text="licensePlate"
        v-model="vehicle"
        hide-details
      ></v-select>
    </v-col>
    <v-col sm="3">
      <v-text-field label="Display Name" solo v-model="displayName"></v-text-field>
    </v-col>
    <v-col sm="3">
      <DatetimePicker label="From" v-model="dateFrom"></DatetimePicker>
    </v-col>
    <v-col sm="3">
      <DatetimePicker label="Until" v-model="dateUntil"></DatetimePicker>
    </v-col>
    <v-col sm="3">
      <v-text-field label="City" solo v-model="city"></v-text-field>
    </v-col>
    <v-col sm="3">
      <v-text-field label="Latitude" solo v-model="cityLat"></v-text-field>
    </v-col>
    <v-col sm="3">
      <v-text-field label="Longitude" solo v-model="cityLng"></v-text-field>
    </v-col>
    <v-col sm="3">
      <v-text-field label="Seats available" solo v-model="seatsAvailable"></v-text-field>
    </v-col>
    <v-col sm="3">
      <v-text-field label="Seats total" solo v-model="seatsTotal"></v-text-field>
    </v-col>
    <v-col sm="3" class="pt-4">
      <v-btn @click="addBooking">
        <v-icon left>fa-plus</v-icon>Add
      </v-btn>
    </v-col>
  </v-row>
</template>

<script>
import moment from "moment";
import { mapState, mapActions } from "vuex";
import DatetimePicker from "../components/DatetimePicker";

export default {
  components: {
    DatetimePicker
  },
  data() {
    return {
      vehicle: null,
      displayName: null,
      city: null,
      cityLat: null,
      cityLng: null,
      seatsAvailable: null,
      seatsTotal: null,
      dateFrom: null,
      dateUntil: null
    };
  },
  methods: {
    addBooking() {
      if (!this.vehicle || !this.dateFrom || !this.dateUntil) {
        this.alertWarning("Please fill all form fields.");
        return;
      }

      this.axios
        .post(
          `vehicles/${this.vehicle.id}/bookings`,
          {
            from: this.dateFrom.toISOString(),
            until: this.dateUntil.toISOString(),
            displayName: this.displayName,
            city: this.city,
            cityLat: this.cityLat,
            cityLng: this.cityLng,
            seatsTotal: this.seatsTotal,
            seatsAvailable: this.seatsAvailable
          },
          this.$root.axiosOptions
        )
        .then(response => {
          if (response.data.success) {
            this.vehicle = null;
            this.dateFrom = null;
            this.dateUntil = null;
            this.$root.loadBookings();
          }
        })
        .catch(err => {
          this.alertError(err.response.data.data);
        });
    },
    ...mapActions(["setBookings", "alertWarning"])
  },
  computed: {
    ...mapState(["bookings", "vehicles"])
  }
};
</script>
