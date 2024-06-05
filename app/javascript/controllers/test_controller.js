import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['output'];

  test() {
    const url = "https://world.openfoodfacts.org/api/v2/product/3270720005174.json"

    fetch(url)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      console.log("name sans fr", data.product.product_name);
      console.log("name avec fr", data.product.product_name_fr);
      console.log("fr", data.product.packaging_text_fr);
      console.log("Ø", data.product.packaging_text);
      console.log("en", data.product.packaging_text_en);
      console.log("pt", data.product.packaging_text_pt);
      console.log("materiaux", data.product.packagings[0].material);
      console.log("packaging tags", data.product.packaging_tags);
    })
  }
}
