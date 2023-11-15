import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shareable-link"
export default class extends Controller {
  static targets = ["contactId"];
  static targets = ['flash'];

  addContact(event) {
    const contactId = event.target.dataset.contactId;

    console.log(`Adding contact with ID: ${contactId}`);

    fetch(`/shareable_link/?contact_id=${contactId}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      },
    })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          // Assuming you want to display a message on success
          console.log(data.message);
        } else {
          console.error(data.message);
        }
      })
      .catch(error => {
        console.error('Error adding contact:', error);
      });
  }
}
