import { initializeApp } from "https://www.gstatic.com/firebasejs/10.14.1/firebase-app.js";
import {
  getFirestore,
  collection,
  addDoc,
} from "https://www.gstatic.com/firebasejs/10.14.1/firebase-firestore.js";

const firebaseConfig = {
  apiKey: "AIzaSyA8v-bKF6sFUedc7j3LpFLBiIEMUn_FpSY",
  authDomain: "projectx-c2b3a.firebaseapp.com",
  projectId: "projectx-c2b3a",
  storageBucket: "projectx-c2b3a.appspot.com",
  messagingSenderId: "760673124560",
  appId: "1:760673124560:web:d9ad87ad48f919ef415ed5",
  measurementId: "G-1GSD8B1QZL",
};

const db = getFirestore(initializeApp(firebaseConfig));

const form = document.getElementById("product-form");
const submitBtn = document.getElementById("submit-btn");
const toast = document.getElementById("toast");

function showToast(message, isError = false) {
  toast.hidden = false;
  toast.textContent = message;
  toast.style.background = isError ? "#ea5b5b" : "#323232";
  window.clearTimeout(showToast._t);
  showToast._t = window.setTimeout(() => {
    toast.hidden = true;
  }, 3200);
}

function setInvalid(input, message) {
  const label = input.closest("label");
  label.classList.toggle("invalid", Boolean(message));
  label.querySelector(".error").textContent = message || "";
}

function validate() {
  let ok = true;
  form.querySelectorAll("label.invalid").forEach((el) => el.classList.remove("invalid"));

  form.querySelectorAll("[required]").forEach((input) => {
    if (!input.value.trim()) {
      setInvalid(input, "Required");
      ok = false;
    }
  });

  return ok;
}

form.addEventListener("submit", async (event) => {
  event.preventDefault();
  if (!validate()) return;

  const data = new FormData(form);
  const imageList = [1, 2, 3, 4, 5]
    .map((i) => (data.get(`image${i}`) || "").trim())
    .filter(Boolean);

  const payload = {
    title: data.get("title").trim(),
    brandName: data.get("brandName").trim(),
    image: data.get("image").trim(),
    price: Number(data.get("price")),
    priceAfterDiscount: Number(data.get("priceAfterDiscount")),
    discountpercent: Number(data.get("discountpercent")),
    ProductInfo: data.get("productInfo").trim(),
    ImageList: imageList,
    ProductRating: {
      rating: Number(data.get("rating")),
      numOfReviews: Number(data.get("numOfReviews")),
      numOfFiveStar: Number(data.get("numOfFiveStar")),
      numOfFourStar: Number(data.get("numOfFourStar")),
      numOfThreeStar: Number(data.get("numOfThreeStar")),
      numOfTwoStar: Number(data.get("numOfTwoStar")),
      numOfOneStar: Number(data.get("numOfOneStar")),
    },
    customerReviews: [],
    mostPopular: false,
    reviews: [],
  };

  submitBtn.disabled = true;
  submitBtn.textContent = "Submitting…";

  try {
    await addDoc(collection(db, "Products"), payload);
    showToast("Product data submitted!");
  } catch (err) {
    console.error(err);
    showToast(err.message || "Failed to submit product", true);
  } finally {
    submitBtn.disabled = false;
    submitBtn.textContent = "Submit Product";
  }
});
