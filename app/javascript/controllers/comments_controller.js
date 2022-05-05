import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    connect() {};

    // Method to handle toggling Edit mode on and off
    toggleForm(event) {
        console.log("I clicked the button");
        // Prevent Page from refreshing
        event.preventDefault();
        // Prevent Page from popping up to top of screen
        event.stopPropagation();

        // Get Edit Form Id
        const formID = event.params["form"];
        // Get Comment Body Id
        const commentBodyID = event.params["body"];
        // Get Edit Button Id
        const editButtonID = event.params["edit"];

        // Grab Edit Form using Id
        const form = document.getElementById(formID);
        // Toggle Visability
        form.classList.toggle("d-none");
        // Add marging top to push below buttons
        form.classList.toggle("mt-5");

        // Grab Comment Body using Id
        const commentBody = document.getElementById(commentBodyID);
        // Toggle Visability
        commentBody.classList.toggle("d-none");

        // Grab Edit Button using Id
        const editButton = document.getElementById(editButtonID);
        // Call toggle Edit Button method on the Edit Button
        this.toggleEditButton(editButton);
    };


    // Method to change Inner Html of Edit Button
    toggleEditButton(editButton) {
        // Check if Innertext is Edit
        if (editButton.innerText === "Edit") {
            // Change text to cancel
            editButton.innerText = "Cancel";
            // Toggle CSS class
            this.toggleEditButtonClass(editButton);

        } else {
            // Change Text to Edit
            editButton.innerText = "Edit";
            // Toggle CSS class
            this.toggleEditButtonClass(editButton);
        }
    };


    // Method to toggle CSS class of edit button
    toggleEditButtonClass(editButton) {
        // Flip Button Styling
        editButton.classList.toggle("btn-secondary");
        editButton.classList.toggle("btn-warning");
    }
};
