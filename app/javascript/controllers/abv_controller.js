import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["og", "fg", "abv_result", "abv_title", "abvCalculate"]

  connect() {
    console.log("ABV controller connected")
  }

  calculateAbv(event) {
    event.preventDefault();
    const og = parseFloat(this.ogTarget.value);
    const fg = parseFloat(this.fgTarget.value);

    console.log("triggering calculation")

    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");

    this.abvCalculateTarget.classList.add("ring-8", "ring-gray-300",
                                          "transition-all", "duration-500", "ease-in-out");

    setTimeout(() => {
      this.abvCalculateTarget.classList.remove("ring-8", "ring-gray-300");
    }, 500);

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
        this.abv_titleTarget.textContent = `ABV:`;
        this.abv_resultTarget.textContent = `${data.abv}%`;

        this.abv_titleTarget.classList.remove("hidden");
        this.abv_resultTarget.classList.remove("hidden");

        this.abv_titleTarget.classList.add("slide-up");
        this.abv_resultTarget.classList.add("slide-up");

        setTimeout(() => {
          this.abv_titleTarget.classList.remove("slide-up");
          this.abv_resultTarget.classList.remove("slide-up");
        }, 1000);
      })
      .catch((error) => {
        console.error("ABV calculation error:", error);
      })
  }
}
