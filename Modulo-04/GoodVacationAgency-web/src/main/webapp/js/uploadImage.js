let imgPhoto = document.getElementById('imgPhoto');
let inputFile = document.getElementById('inputFile');
// let divPhoto = document.getElementById('divPhoto');

// divPhoto.addEventListener('click', () => {
//     inputFile.click();
// });

inputFile.addEventListener('change', () => {

    if (inputFile.files.length <= 0) {
        return;
    }

    let reader = new FileReader();

    reader.onload = () => {
        imgPhoto.src = reader.result;
    }

    reader.readAsDataURL(inputFile.files[0]);
});

// const inputFile = document.querySelector("#picture__input");
// const pictureImage = document.querySelector(".picture__image");
// const pictureImageTxt = "Choose an image";
// pictureImage.innerHTML = pictureImageTxt;

// inputFile.addEventListener("change", function (e) {
//   const inputTarget = e.target;
//   const file = inputTarget.files[0];

//   if (file) {
//     const reader = new FileReader();

//     reader.addEventListener("load", function (e) {
//       const readerTarget = e.target;

//       const img = document.createElement("img");
//       img.src = readerTarget.result;
//       img.classList.add("picture__img");

//       pictureImage.innerHTML = "";
//       pictureImage.appendChild(img);
//     });

//     reader.readAsDataURL(file);
//   } else {
//     pictureImage.innerHTML = pictureImageTxt;
//   }
// });
