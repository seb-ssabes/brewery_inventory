import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("TOAST")

    setTimeout(() => {
      this.element.classList.remove("opacity-0");
    }, 100);

    setTimeout(() => {
      this.element.classList.add("opacity-0")
    }, 4000)
  }
}
