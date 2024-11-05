import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sort"]

  connect() {
    console.log("Sort controller connected")
  }

  // handleSort() {

  // }
}
