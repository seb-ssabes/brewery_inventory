import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // static targets = ["list"]

  connect() {
    console.log("Sort controller connected")
  }

  toggleSort(event) {
    console.log("Toggled")
    const sortBy = event.target.checked ? 'quantity' : 'origin'
    const categoryId = this.listTarget.dataset.categoryId

    console.log(`Category ID: ${categoryId}`);

    fetch(`/items/toggle_sort?sort_by=${sortBy}&category_id=${categoryId}`, {
      headers: { Accept: "text/vnd.turbo-stream.html" }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.text();
    })
    .then(html => {
      // You can handle the HTML response here if necessary
      console.log("Response received");
    })
    .catch(error => {
      console.error('There was a problem with the fetch operation:', error);
    });
  }
}
