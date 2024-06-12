import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {

    console.log('Hello, Stimulus!');
    console.log('Product controller connected');

    // Custom Event Listener for Stimulus (See Thomas for help if needed)
    document.addEventListener('product:created', this.handleProductCreated.bind(this));

    document.addEventListener('click', this.handlePageClick.bind(this));

  }

  // When the custom event is triggered in barcode_scanner.js
  handleProductCreated(event) {
    const newProduct = event.detail.product;
    console.log(`Stimulus Info === New product created: NAME : ${newProduct.name}, IMAGE URL : (${newProduct.imageUrl}), MATERIAL : (${newProduct.material}), DESCRIPTION : (${newProduct.description}), LINK : (${newProduct.link})`);

    // Variable to check if the card is already displayed (different animation if it is already displayed)
    var card = document.getElementById('product-card');
    var cardClass = card.className;

    switch (cardClass) {

      // If the card is not displayed, display it with a popup animation
      case "d-none":
        document.getElementById('product-card').innerHTML = '';
        document.getElementById('product-card').insertAdjacentHTML('beforeend',`

                <div id="product-card-top">
                  <div id="pill" ></div>
                </div>
                <div id="product-card-middle">
                  <img src="${newProduct.imageUrl}">
                  <div>
                    <h1>${newProduct.name}</h1>
                    <h2>${newProduct.description}</h2>
                    <div id=${newProduct.material}>
                      ${newProduct.material}
                    </div>
                  </div>
                </div>
                <div id="product-card-bottom">
                  <a href=${newProduct.link} class="product-link">
                    <btn>Trouver une poubelle</btn>
                  </a>
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

          <div id="product-card-top">
            <div id="pill" ></div>
          </div>
          <div id="product-card-middle">
            <img src="${newProduct.imageUrl}">
            <div>
              <h1>${newProduct.name}</h1>
              <h2>${newProduct.description}</h2>
              <div id=${newProduct.material}>
                ${newProduct.material}
              </div>
            </div>
          </div>
          <div id="product-card-bottom">
            <a href=${newProduct.link} class="product-link">
              <btn>Trouver une poubelle</btn>
            </a>
          </div>

          `);
        }, 500);
    }
  }

  handlePageClick(event) {
    // Check if the clicked element or any of its parents has the class 'hello'
    const videoElement = event.target.closest('#video');
    if (videoElement) {
      console.log('Element with id "video" was clicked', videoElement);

      var card = document.getElementById('product-card');
      var cardClass = card.className;

      if (cardClass === 'd-none') {
        console.log('Card is hidden');
      } else {
        document.getElementById('product-card').style.animation="popdown 0.5s linear";
        setTimeout(() => {
          document.getElementById('product-card').classList.add('d-none');
        }, 500);
      }
    }
  }

}
