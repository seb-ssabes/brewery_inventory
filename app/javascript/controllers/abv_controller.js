import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["og", "fg", "abv_result"]

  connect() {
    console.log("ABV controller connected")
  }

  calculateAbv(event) {
    event.preventDefault();
    const og = parseFloat(this.ogTarget.value);
    const fg = parseFloat(this.fgTarget.value);

    console.log("triggering calculation")

    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");

    fetch("/calculators/calculate_abv", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({og, fg})
    })
      .then((response) => response.json())
      .then((data) => {
        this.abv_resultTarget.textContent = `ABV: ${data.abv}%`;
      })
      .catch((error) => {
        console.error("ABV calculation error:", error);
      })
  }
}
