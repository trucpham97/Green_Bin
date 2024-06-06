import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {

    console.log('Product controller connected');

    // Custom Event Listener for Stimulus (See Thomas for help if needed)
    document.addEventListener('product:created', this.handleProductCreated.bind(this));

  }

  // When the custom event is triggered in barcode_scanner.js, this function is called
  handleProductCreated(event) {
    const newProduct = event.detail.product;
    console.log(`New product created: ${newProduct.name} (${newProduct.imageUrl}) (${newProduct.material})`);

    // Variable to check if the card is already displayed (different animation if it is already displayed)
    var card = document.getElementById('product-card');
    var cardClass = card.className;

    switch (cardClass) {

      // If the card is not displayed, display it with a popup animation
      case "d-none":
        document.getElementById('product-card').innerHTML = '';
        document.getElementById('product-card').insertAdjacentHTML('beforeend',`

                <img src="${newProduct.imageUrl}">
                <div>
                  <h1>${newProduct.name}</h1>
                  <br>
                  <h1>${newProduct.material}</h1>
                  <br>
                  <h2>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</h2>
                </div>

        `);
        document.getElementById('product-card').classList.remove('d-none');
        document.getElementById('product-card').style.animation="popup 0.5s linear";
        break;

      // If the card is already displayed, display it with a popdown animation and then a popup animation
      default:
        document.getElementById('product-card').style.animation="popdown 0.5s linear";
        setTimeout(() => {
          document.getElementById('product-card').style.animation="popup 0.5s linear";
        }, 100);
        setTimeout(() => {
          document.getElementById('product-card').innerHTML = '';
          document.getElementById('product-card').insertAdjacentHTML('beforeend',`

                  <img src="${newProduct.imageUrl}">
                  <div>
                    <h1>${newProduct.name}</h1>
                    <br>
                    <h1>${newProduct.material}</h1>
                    <br>
                    <h2>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</h2>
                  </div>

          `);
        }, 500);
    }
  }
}
