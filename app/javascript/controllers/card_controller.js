import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card"]

  isTouching = false;

  connect() {
    console.log("Card controller connected")
  }

  touchstart(event) {
    if (this.isTouching) return;
    this.isTouching = true;

    console.log("touchstart")
    event.currentTarget.classList.add("item-card-active");
  }

  touchend(event) {
    if (!this.isTouching) return;
    this.isTouching = false

    console.log("touchend")

    event.currentTarget.classList.remove("item-card-active")

    const card = event.currentTarget;
    window.location.href = card.dataset.url;
  }
}
