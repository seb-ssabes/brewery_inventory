import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card"]

  isClicked = false;

  connect() {
    console.log("Card controller connected");

    this.cardTargets.forEach(card => {
      card.addEventListener('click', this.handleClick.bind(this));
      // card.addEventListener('touchend', this.touchend.bind(this));
    });
  }

  handleClick(event) {
    console.log("Card clicked");

    if (this.isClicked) {
      console.log("Already touching, skipping.");
      return;
    }
    this.isClicked = true;

    // event.preventDefault();

    event.currentTarget.classList.add("item-card-active");

    setTimeout(() => {
      window.location.href = card.dataset.url;
    }, 100);
  }

  // touchend(event) {
  //   console.log("touchend");
  //   event.stopPropagation();

  //   if (!this.isTouching) {
  //     console.log("No valid touch to end");
  //     return;
  //   }
  //   this.isTouching = false

  //   this.clearTouchFeedback(event);

  //   const card = event.currentTarget;

  //   setTimeout(() => {
  //     window.location.href = card.dataset.url;
  //   }, 100);

  //   if (this.navigating) {
  //     console.log("Already navigating, skipping");
  //     return;
  //   }
  //   this.navigating = true;
  //   window.location.href = card.dataset.url;
  // }

  // clearTouchFeedback(event) {
  //   event.currentTarget.classList.remove("item-card-active");
  //   console.log("Removed active class and cleared timeout");
  // }
}
