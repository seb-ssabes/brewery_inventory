import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["quantityDisplay", "quantityInput"]

  connect() {
    console.log("Quantity controller connected")
    this.quantityInputTarget.value = this.quantityDisplayTarget.innerText.trim().split(" ")[0];
  }

  increase() {
    let currentQuantity = parseInt(this.quantityInputTarget.value);
    let amountToAdd = prompt("How many grams would you like to add?", "0");

    if (amountToAdd && !isNaN(amountToAdd)) {
      currentQuantity += parseInt(amountToAdd);
      this.updateQuantity(currentQuantity);
    }
  }

  decrease() {
    let currentQuantity = parseInt(this.quantityInputTarget.value);
    let amountToSubstract = prompt("How many grams would you like to substract?", "0");

    if (amountToSubstract && !isNaN(amountToSubstract)) {
      currentQuantity = Math.max(0, currentQuantity - parseInt(amountToSubstract));
      this.updateQuantity(currentQuantity);
    }
  }

  updateQuantity(newQuantity) {
    this.quantityInputTarget.value = newQuantity;
    this.quantityDisplayTarget.innerText = `${newQuantity}`
  }
}
