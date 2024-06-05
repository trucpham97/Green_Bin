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
    document.getElementById('product-card').insertAdjacentHTML('beforeend', `${newProduct.name} <br> <img src="${newProduct.imageUrl}">`);
  }
}
