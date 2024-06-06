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
      }

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
                console.log("image", data.product.image_url);

                // Different ways to get the material of the product
                console.log(data?.product?.packagings[0]?.material ?? 'Information non disponible');
                console.log(data?.product?.packaging_tags ?? 'Information non disponible');

                // Fill Form with product data
                document.getElementById('product_name').value = data.product.product_name;
                document.getElementById('product_image_url').value = data.product.image_url;
                const material = data?.product?.packagings[0]?.material ?? 'Information non disponible';
                document.getElementById('product_material').value = material;
                console.log(data?.product?.packaging_text_fr);
                const description = data?.product?.packaging_text_fr ?? 'Description non disponible';
                document.getElementById('product_description').value = description;

                // Form Auto-Submit
                // document.getElementById('product-form').submit();
                const form = document.getElementById('product-form');

                const url = form.action;
                const formData = new FormData(form);
                fetch(url, {
                  method: 'POST',
                  'Accept': 'application/json',
                  body: formData
                })
                .then(response => response.json())
                .then(data => console.log(data))

                document.getElementById('product-card').innerHTML = '';

                // Custom Event for Stimulus in product_controller.js (ask Thomas for help if needed)
                const newProduct = { name: data.product.product_name,
                  imageUrl: data.product.image_url,
                  material: material};
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
