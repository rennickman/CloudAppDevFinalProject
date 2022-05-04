import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    connect() {};

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
    };
};
