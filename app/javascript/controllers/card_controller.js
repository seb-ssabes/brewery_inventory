import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card"]

  isTouching = false;

  connect() {
    console.log("Card controller connected")
  }

  touchstart(event) {
    console.log("touchstart");

    if (this.isTouching) {
      console.log("Already touching, skipping.");
      return;
    }
    this.isTouching = true;

    event.preventDefault();

    event.currentTarget.classList.add("item-card-active");
  }

  touchend(event) {
    console.log("touchend")

    if (!this.isTouching) {
      console.log("No valid touch to end");
      return;
    }
    this.isTouching = false

    this.clearTouchFeedback(event);

    const card = event.currentTarget;
    window.location.href = card.dataset.url;
  }

  clearTouchFeedback(event) {
    clearTimeout(this.touchHoldTimeout);
    event.currentTarget.classList.remove("item-card-active");
    console.log("Removed active class and cleared timeout");
  }
}
