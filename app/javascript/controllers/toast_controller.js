import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["notice"]

  connect() {
    console.log("TOAST controller connected");
    if (this.noticeTarget && this.noticeTarget.innerHTML.trim() !== "") {
    this.showToast()
    }
  }

  showToast() {
    setTimeout(() => {
      this.noticeTarget.classList.remove("opacity-0");
    }, 100);

    setTimeout(() => {
      this.noticeTarget.classList.add("opacity-0");
    }, 3000)
  }
}
