import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["suggestions", "input"]

  connect() {
    this.inputTarget.addEventListener('keyup', this.searchInput.bind(this));
    this.inputTarget.addEventListener('change', this.searchInput.bind(this));
  }

  searchInput() {
    const query = this.inputTarget.value.trim().toLowerCase();
    console.log(query)

    if (query === "") {
      this.suggestionsTarget.innerHTML = "";
      return;
    }

    fetch(`/hops/api_search?query=${encodeURIComponent(query)}`, {
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    })
      .then((response) => {
        // console.log("Response status:", response.status);
        // console.log("Response headers:", response.headers);
        return response.json();
      })
      .then((data) => {
        // console.log("Data received from server:", data);
        this.updateSuggestions(data, query);
      })
      .catch((error) => {
        console.error("Fetch error:", error)
      })
  }

  updateSuggestions(hops, query) {
    this.suggestionsTarget.innerHTML = "";

    if (hops.length === 0) {
      this.suggestionsTarget.innerHTML = "<li>No hops found</li>";
      return
    }

    const html = hops.map(hop => {
      const regex = new RegExp(query, 'gi');
      const highlightedName = hop.name.replace(regex, `<span class="hl">${query}</span>`)

      return `
        <li class="suggestion-item">
          <span class="name">${highlightedName}</span>
        </li>
      `
    }).join('');

    this.suggestionsTarget.innerHTML = html
  }
}
