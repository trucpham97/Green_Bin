import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    console.log("Map controller connected")
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/trucpham97/clx33jtwc01rh01ny0m5u1w1y",
      center: [0, 0], // starting position [lng, lat], this will be updated later
      zoom: 2
    })
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        const userLocation = [position.coords.longitude, position.coords.latitude];

        // Center the map on the user's location
        this.map.setCenter(userLocation);
        // Adjust zoom level as needed
        this.map.setZoom(14);

        // Add a marker at the user's location
        new mapboxgl.Marker()
          .setLngLat(userLocation)
          .setPopup(new mapboxgl.Popup({ offset: 25 })
          .setHTML('<h4>Je suis ici</h4>'))
          .addTo(this.map);
      }, (error) => {
        console.error('Error obtaining geolocation', error);
      });
    } else {
      console.error('Geolocation is not supported by this browser.');
    }

    this.#addMarkersToMap()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }
}
