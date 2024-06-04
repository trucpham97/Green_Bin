import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['output'];

  test() {
    const url = "https://data.grandlyon.com/fr/datapusher/ws/grandlyon/gic_collecte.siloverre/all.json?maxfeatures=-1&start=1"

    fetch(url)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      data.values.forEach(silo => {
        console.log(silo.lon);
        console.log(silo.lat);
        console.log(silo.adresse);
        console.log(silo.horaires);
      });
    })
  }
}
