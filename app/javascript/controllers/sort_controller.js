import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list", "ring"]

  toggleSort(event) {
    const sortBy = event.target.checked ? "quantity" : "origin";
    const categoryId = this.listTarget.dataset.categoryId;

    this.ringTarget.classList.add("peer-focus:ring-8",
                                  "peer-focus:ring-gray-400",
                                  "transition-all",
                                  "duration-1000",
                                  "ease-in-out");

    setTimeout(() => {
      this.ringTarget.classList.remove("peer-focus:ring-8",
                                       "peer-focus:ring-gray-400");
    }, 500);

    this.listTarget.classList.remove("opacity-100");
    this.listTarget.classList.add("opacity-0");

    fetch(`/items/toggle_sort?sort_by=${sortBy}&category_id=${categoryId}`, {
      headers: { "Content-Type": "application/json" },
    })

    .then((response) => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.text();
    })

    .then((html) => {
      setTimeout(() => {
        this.listTarget.innerHTML = html;

        this.listTarget.classList.remove("opacity-0");
        this.listTarget.classList.add("opacity-100");
      }, 300);
    })
  }
}
