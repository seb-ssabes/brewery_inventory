import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["notice"]

  connect() {
    if (!this.hasNoticeTarget) {
      console.log('No flash notice detected');
      return;
    }
    console.log("TOAST controller connected");
    this.showToast();
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
