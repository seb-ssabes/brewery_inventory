import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["measured_density", "current_temp", "densimeter_temp", "corrected_density"]

  connect() {
    console.log("Density controller connected")
  }

  correctDensity(event) {
    event.preventDefault();
    const measured_density = parseFloat(this.measured_densityTarget.value).toFixed(3);
    const current_temp = parseFloat(this.current_tempTarget.value);
    const densimeter_temp = parseFloat(this.densimeter_tempTarget.value);

    console.log("triggering calculation")

    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");

    fetch("/calculators/calculate_density_correction", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({measured_density, current_temp, densimeter_temp})
    })
      .then((response) => response.json())
      .then((data) => {
        this.corrected_densityTarget.textContent = `Corrected density: ${data.corrected_density}`;
      })
      .catch((error) => {
        console.error("Corrected density calculation error:", error);
      })
  }
}
