import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["suggestions", "input"]

  connect() {
    this.inputTarget.addEventListener('keyup', this.searchInput.bind(this));
    this.suggestionsTarget.addEventListener('click', this.selectSuggestion.bind(this))
  }

  searchInput() {
    this.clearSuggestions();
    this.clearDetails();

    const query = this.inputTarget.value.trim().toLowerCase();

    if (query === "") {
      return;
    }

    fetch(`/hops/api_search?query=${encodeURIComponent(query)}`, {
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    })
      .then((response) => response.json())
      .then((data) => this.updateSuggestions(data, query))
  }

  updateSuggestions(hops, query) {
    this.suggestionsTarget.innerHTML = "";

    if (hops.length === 0) {
      this.suggestionsTarget.innerHTML = "<li>No hops found</li>";
      this.suggestionsTarget.classList.remove("hidden");
      return
    }

    const html = hops.map((hop) => `
        <li class="suggestion-item" data-hop-name="${hop.name}">
          <span class="name">${hop.name}</span>
        </li>
      `
    ).join('');

    this.suggestionsTarget.innerHTML = html;
    this.suggestionsTarget.classList.remove("hidden");
  }

  selectSuggestion(event) {
    const hopElement = event.target.closest(".suggestion-item");
    if (!hopElement) return;

    const hopName = hopElement.getAttribute("data-hop-name");

    fetch(`/hops/api_detail?name=${encodeURIComponent(hopName)}`, {
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    })
      .then((response) => response.json())
      .then((data) => {
        this.populateForm(data);
        this.clearSuggestions();
      })
      .catch((error) => console.error("Fetch error:", error));
  }

  clearSuggestions() {
    this.suggestionsTarget.classList.add("hidden");
  }

  populateForm(hopData) {
    this.clearDetails();

    const detalisContainer = document.createElement("div");
    detalisContainer.innerHTML = `
      <div class="hop-details">
        <h2>${hopData.name}</h2>
        <p><strong>Aroma/Taste:</strong> ${hopData.aroma}</p>
        <p><strong>Alpha Acid:</strong> ${hopData.alpha}</p>
        <p><strong>Type:</strong> ${hopData.hop_type}</p>
        <p><strong>Substitute Hops:</strong> ${hopData.substitutes}</p>
      </div>
    `;
    const form = this.inputTarget.closest("form");
    form.appendChild(detalisContainer)
  }

  clearDetails() {
    const existingDetails = document.querySelector(".hop-details");
    if (existingDetails) {
      existingDetails.remove();
    }
  }
}
