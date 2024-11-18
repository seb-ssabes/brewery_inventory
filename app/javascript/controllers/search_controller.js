import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["suggestions", "input"]

  connect() {
    this.inputTarget.addEventListener('keyup', this.searchInput.bind(this));
    this.suggestionsTarget.addEventListener('click', this.selectSuggestion.bind(this))
    console.log("Search controller connected")
  }

  searchInput() {
    this.clearDetails();

    const query = this.inputTarget.value.trim().toLowerCase();

    if (query === "") {
      this.clearSuggestions();
      return;
    }

    const timestamp = new Date().getTime();
    fetch(`/hops/api_search?query=${encodeURIComponent(query)}&t=${timestamp}`, {
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        // "Cache-Control": "no-cache, no-store, must-revalidate",
        // "Pragma": "no-cache",
        // "Expires": "0",
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

    const html = hops.map((hop, index) => `
        <li class="suggestion-item mt-2 opacity-0 transform -translate-y-2"
            style="animation-delay: ${index * 50}ms" data-hop-name="${hop.name}">
          <span class="name">${hop.name}</span>
        </li>
      `
    ).join('');

    this.suggestionsTarget.innerHTML = html;
    this.suggestionsTarget.classList.remove("hidden");

    requestAnimationFrame(() => {
      const items = this.suggestionsTarget.querySelectorAll('.suggestion-item');
      items.forEach((item) => {
        item.classList.remove("fade-in");
        void item.offsetWidth;
        item.classList.add("fade-in");
      })
    })
  }

  selectSuggestion(event) {
    const hopElement = event.target.closest(".suggestion-item");
    if (!hopElement) return;

    const hopName = hopElement.getAttribute("data-hop-name");

    this.inputTarget.value = ""

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
    const items = this.suggestionsTarget.querySelectorAll('.suggestion-item');

    if (items.length === 0) return;

    items.forEach((item) => {
      item.classList.remove("fade-in");
      item.classList.add("fade-out");
    })

    setTimeout(() => {
      items.forEach((item) => {
        item.classList.remove("fade-out");
      });
      this.suggestionsTarget.classList.add("hidden");
      this.suggestionsTarget.classList.remove("fade-out-container")
    }, 350);
  }

  populateForm(hopData) {
    this.clearDetails();

    const detalisContainer = document.createElement("div");
    detalisContainer.id = "detailsContainer";

    detalisContainer.classList.add("opacity-0", "transition-opacity", "duration-500")
    detalisContainer.innerHTML = `
      <table class="w-full text-lg text-left text-gray-500 dark:text-gray-400">
        <h2 class="text-2xl text-center font-bold">${hopData.name}</h2>
          <tbody>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
              <th scope="row" class="w-1/3 px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                Aroma/Taste:
              </th>
              <td class="w-2/3 pr-6 py-4 pl-3">
                ${this.formatAroma(hopData.aroma)}
              </td>
            </tr>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
              <th scope="row" class="w-1/3 px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                  Alpha Acid
              </th>
              <td class="w-2/3 pr-6 py-4 pl-3">
                ${hopData.alpha}
              </td>
            </tr>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
              <th scope="row" class="w-1/3 px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                  Type
              </th>
              <td class="w-2/3 pr-6 py-4 pl-3">
                ${hopData.hop_type}
              </td>
            </tr>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
              <th scope="row" class="w-1/3 px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                  Substitutes
              </th>
              <td class="w-2/3 pr-6 py-4 pl-3 mb-10">
                ${this.formatSubstitutes(hopData.substitutes)}
              </td>
            </tr>
          </tbody>
      </table>
    `;
    const form = document.getElementById("table");
    form.appendChild(detalisContainer)

    setTimeout(() => {
      detalisContainer.classList.remove("opacity-0");
      detalisContainer.classList.add("opacity-100");
    }, 350);
  }

  clearDetails() {
    const existingDetails = document.getElementById("detailsContainer");

    if (existingDetails) {
      existingDetails.classList.remove("opacity-100", "transition-opacity", "duration-300");
      existingDetails.classList.add("opacity-0", "transition-opacity", "duration-300");

      setTimeout(() => {
        existingDetails.remove()
      }, 300);
    }
  }

  formatAroma(aromaString) {
    if (!aromaString) return "";

    const aromaArray = aromaString.split(" • ");
    const formattedList = aromaArray.map((item) => `• ${item.charAt(0).toUpperCase() + item.slice(1)}`).join("<br>");

    return formattedList;
  }

  formatSubstitutes(substituteString) {
    if (!substituteString) return "";

    const substitutesArray = substituteString.split(" | ");
    const formattedList = substitutesArray.map((item) => `• ${item.charAt(0).toUpperCase() + item.slice(1)}`).join("<br>");

    return formattedList;
  }
}
