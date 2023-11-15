import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["contact"];


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
          console.log(data.message);

          console.log(contactId)
          const contactContainer = this.contactTargets.find(container => container.dataset.contactId === contactId);
          console.log(contactContainer)
          this.removeContact(contactId);
        } else {
          console.error(data.message);
        }
      })
      .catch(error => {
        console.error('Error adding contact:', error);
      });
  }

  removeContact(contactId) {
    const contactContainer = this.contactTargets.find(container => container.dataset.contactId === contactId);

    if (contactContainer) {
      contactContainer.remove();
    }
  }
}
