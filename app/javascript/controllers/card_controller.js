import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card"]

  connect() {
    console.log("Card controller connected")
  }

  handleClick(event) {
    console.log("Card clicked");

    event.currentTarget.classList.add("item-card-active");

    console.log("Redirecting...")

    window.location.href = event.currentTarget.dataset.url;
  }
}
