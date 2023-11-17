import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import "flatpickr/dist/l10n/pt.js"


// /flatpickr/dist/esm/l10n/pt.js
export default class extends Controller {

  connect() {
    flatpickr(".birthday-date", {
      locale: "pt",
      altInput: true,
      altFormat: "j F, Y",
      dateFormat: "Y-m-d",
      inline: true
    })
  }


}
