import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

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
      zoom: 2,
      attributionControl: false
    })
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        const userLocation = [position.coords.longitude, position.coords.latitude];

        // Center the map on the user's location
        this.map.setCenter(userLocation);
        // Adjust zoom level as needed
        this.map.setZoom(14);

        // Add a marker at the user's location
        // Customize the marker by creating a 'div' element with custom styles
        const currentUserLocationMarker = document.createElement('div');
        currentUserLocationMarker.className = 'user-marker';

        // Add the custom marker to the map
        new mapboxgl.Marker(currentUserLocationMarker)
          .setLngLat(userLocation)
          .setPopup(new mapboxgl.Popup({ offset: 25 })
          .setHTML('<h4>🤡</h4>'))
          .addTo(this.map);
      }, (error) => {
        console.error('Error obtaining geolocation', error);
      });
    } else {
      console.error('Geolocation is not supported by this browser.');
    }

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    // Add the search to the map
    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl }))
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      const spot = document.createElement("div")
      spot.innerHTML = marker.marker_html

      new mapboxgl.Marker(spot)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    // Limit the number of markers to 3
    const limitedMarkers = this.markersValue.slice(0, 3)
    limitedMarkers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 30, maxZoom: 20, duration: 0 })
  }
}
