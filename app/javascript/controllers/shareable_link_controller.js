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
          this.removeContact(contactId);
          this.showFlash(data.message);
        } else {
          this.showFlash(data.message)
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

  showFlash(message) {
    // Create a new div element
    const flashDiv = document.createElement('div');

    // Set the HTML content for the new div
    flashDiv.innerHTML = `
      <div class="alert alert-info alert-dismissible fade show m-1" role="alert">
        <span id="flash-notice">${message}</span>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    `;

    // Append the new div to the body or the appropriate container
    document.body.appendChild(flashDiv);

    // Optional: Add a timeout to remove the flash after a certain duration
    setTimeout(() => {
      flashDiv.remove();
    }, 5000);
  }
}
