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
          console.log(result)
          document.getElementById('result').textContent = result.text

          async function fetchProduct() {
            try {
                const response = await fetch(`https://world.openfoodfacts.org/api/v0/product/${result}.json`);
                const data = await response.json();
                console.log("Your product is :", data.product.product_name);
                document.getElementById('product-id').textContent = data.product.product_name
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
})
