function setCookie(name, value, days) {
  const date = new Date();
  date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
  const expires = "expires=" + date.toUTCString();
  document.cookie = name + "=" + value + ";" + expires + ";path=/";
}

function getCookie(name) {
  const value = `; ${document.cookie}`;
  const parts = value.split(`; ${name}=`);
  if (parts.length === 2) return parts.pop().split(';').shift();
}

function checkCameraPermission() {
  const cameraPermission = getCookie('camera_permission');
  console.log("Camera permission cookie:", cameraPermission);

  if (cameraPermission === 'granted') {
    startCamera();
  } else {
    navigator.permissions.query({ name: 'camera' }).then(function (permissionStatus) {
      console.log("Permission status:", permissionStatus.state);
      if (permissionStatus.state === 'granted') {
        setCookie('camera_permission', 'granted', 7); // Store permission for 7 days
        startCamera();
      } else if (permissionStatus.state === 'prompt' || permissionStatus.state === 'denied') {
        navigator.mediaDevices.getUserMedia({ video: true })
          .then(function (stream) {
            console.log("Camera access granted");
            setCookie('camera_permission', 'granted', 7); // Store permission for 7 days
            startCamera();
          })
          .catch(function (err) {
            console.log("Camera access denied or error occurred:", err);
          });
      }
    });
  }
}

function startCamera() {
  console.log("Starting camera...");
  let selectedDeviceId;
  const codeReader = new ZXing.BrowserMultiFormatReader();
  console.log('ZXing code reader initialized');

  codeReader.listVideoInputDevices()
    .then((videoInputDevices) => {
      selectedDeviceId = videoInputDevices[0].deviceId;
      console.log('videoInputDevices', videoInputDevices);
      console.log('deviceId', selectedDeviceId);
      if (videoInputDevices.length >= 1) {
        const sourceSelect = document.getElementById('sourceSelect');
        console.log('sourceSelect', sourceSelect);
        videoInputDevices.forEach((element) => {
          const sourceOption = document.createElement('option');
          console.log('sourceOption', sourceOption);
          sourceOption.text = element.label;
          sourceOption.value = element.deviceId;
          sourceSelect.appendChild(sourceOption);
        });

        sourceSelect.onchange = () => {
          selectedDeviceId = sourceSelect.value;
        };
      }

      codeReader.decodeFromVideoDevice(selectedDeviceId, 'video', (result, err) => {
        if (result) {
          if (this.lastResultCode === result.text) return;
          this.lastResultCode = result.text;

          console.log(result);
          document.getElementById('result').textContent = result.text;

          async function fetchProduct() {
            try {
              const response = await fetch(`https://world.openfoodfacts.org/api/v0/product/${result.text}.json`);
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
              let material_fr;

              // Translate material to French (I know it's ugly, but it works for now)
              if (material.includes('plastic')) {
                material_fr = 'Plastique';
              } else if (material.includes('pet-1-polyethylen-terephthalate')) {
                material_fr = 'Plastique';
              } else if (material.includes('pet-1-polyethylene-terephthalate')) {
                material_fr = 'Plastique';
              } else if (material.includes('glass')) {
                material_fr = 'Verre';
              } else if (material.includes('green-glass')) {
                material_fr = 'Verre';
              } else if (material.includes('clear-glass')) {
                material_fr = 'Verre';
              } else if (material.includes('bottle')) {
                material_fr = 'Verre';
              } else if (material.includes('cardboard')) {
                material_fr = 'Carton';
              } else if (material.includes('paperboard')) {
                material_fr = 'Carton';
              } else if (material.includes('aluminum')) {
                material_fr = 'Aluminium';
              } else if (material.includes('canned')) {
                material_fr = 'Aluminium';
              } else if (material.includes('metal')) {
                material_fr = 'Metal';
              } else if (material.includes('steel')) {
                material_fr = 'Metal';
              } else {
                material_fr = 'Indisponible';
              }

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
                .then(data => {
                  const id = data.id;
                  const cardLink = document.querySelector('.product-link');
                  cardLink.href = `/products/${id}/recycling_spots`;
                });

              document.getElementById('product-card').innerHTML = '';
              // Custom Event for Stimulus in product_controller.js (ask Thomas for help if needed)
              const newProduct = {
                name: data.product.product_name,
                imageUrl: data.product.image_url,
                material: material_fr
              };
              document.dispatchEvent(new CustomEvent('product:created', { detail: { product: newProduct } }));

            } catch (error) {
              console.error('Erreur lors de la récupération du produit:', error);
            }
          }

          fetchProduct();

        }
        if (err && !(err instanceof ZXing.NotFoundException)) {
          console.error(err);
          document.getElementById('result').textContent = err;
        }
      });
      console.log(`Started continuous decode from camera with id ${selectedDeviceId}`);

    })
    .catch((err) => {
      console.error(err);
    });
}

// Check permission when the page loads
window.addEventListener('load', function () {
  checkCameraPermission();
});
