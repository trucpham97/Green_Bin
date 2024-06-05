import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('Product controller connected');
    document.addEventListener('product:created', this.handleProductCreated.bind(this));
  }

  handleProductCreated(event) {
    const newProduct = event.detail.product;
    console.log(`New product created: ${newProduct.name} (${newProduct.imageUrl})`);

    document.getElementById('product-card').innerHTML = '';
    document.getElementById('product-card').insertAdjacentHTML('beforeend',`
      <img src="${newProduct.imageUrl}">
      <div>
        <h1>
          ${newProduct.name}
        </h1>
        <br>
        <h2>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        </h2>
      </div>
    `);
    document.getElementById('product-card').classList.remove('d-none');
  }
}
