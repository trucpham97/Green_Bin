window.addEventListener('load', function () {
  let selectedDeviceId;
  const codeReader = new ZXing.BrowserMultiFormatReader()
  console.log('ZXing code reader initialized')
  codeReader.listVideoInputDevices()
    .then((videoInputDevices) => {
      selectedDeviceId = videoInputDevices[0].deviceId
      if (videoInputDevices.length >= 1) {
        const sourceSelect = document.getElementById('sourceSelect')
        videoInputDevices.forEach((element) => {
          const sourceOption = document.createElement('option')
          sourceOption.text = element.label
          sourceOption.value = element.deviceId
          sourceSelect.appendChild(sourceOption)
        })

        sourceSelect.onchange = () => {
          selectedDeviceId = sourceSelect.value;
        };

        // const sourceSelectPanel = document.getElementById('sourceSelectPanel')
        // sourceSelectPanel.style.display = 'block'
      }

      // Start scanning as soon as the page loads
      codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
        if (result) {
          if (this.lastResultCode === result.text) return;
          this.lastResultCode = result.text;

          console.log(result)
          document.getElementById('result').textContent = result.text

          async function fetchProduct() {
            try {

                const response = await fetch(`https://world.openfoodfacts.org/api/v0/product/${result}.json`);
                const data = await response.json();
                console.log("Your product is :", data.product.product_name);
                document.getElementById('product-id').textContent = data.product.product_name
                console.log("image", data.product.image_url);
                document.getElementById('product-images').innerHTML = '';
                document.getElementById('product-images').insertAdjacentHTML('beforeend', `<img src="${data.product.image_url}" alt="product image">`);
                // Fill Form with product data
                document.getElementById('product_name').value = data.product.product_name;
                document.getElementById('product_image_url').value = data.product.image_url;
                // Form Auto-Submit
                document.getElementById('product-form').submit();
                document.getElementById('product-card').innerHTML = '';
                document.getElementById('product-card').insertAdjacentHTML('beforeend', `<div style="background-color: red">${data.product.product_name} <br> <img src="${data.product.image_url}"> </div>`);
                // Custom Event for Stimulus in product_controller.js (ask Thomas for help if needed)
                const newProduct = { name: data.product.product_name, imageUrl: data.product.image_url };
                document.dispatchEvent(new CustomEvent('product:created', { detail: { product: newProduct } }));


            } catch (error) {
                console.error('Erreur lors de la récupération du produit:', error);
            }
        }

        fetchProduct();

        }
        if (err && !(err instanceof ZXing.NotFoundException)) {
          console.error(err)
          document.getElementById('result').textContent = err
        }
      })
      console.log(`Started continuous decode from camera with id ${selectedDeviceId}`)

    })
    .catch((err) => {
      console.error(err)
    })
}, {once: true})
