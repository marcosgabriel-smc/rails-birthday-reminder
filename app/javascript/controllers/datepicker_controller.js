import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
// import { Portuguese} from "flatpickr/dist/l10n/ru.js"


export default class extends Controller {

  connect() {
    console.log("funfa")
    flatpickr(".birthday-date", {
      // "locale": "ru",
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      inline: true
    })
  }


}
