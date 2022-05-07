import { Controller } from '@hotwired/stimulus';


export default class extends Controller {

    connect() {
        // Set messages
        const messages = document.getElementById("messages");
        // Add event listener
        messages.addEventListener("DOMNodeInserted", this.resetScroll);
        // Reset scroll when event is fired
        this.resetScroll(messages);
    };


    disconnect() {
    };

    // Method to reset scroll
    resetScroll() {
        messages.scrollTop = messages.scrollHeight - messages.clientHeight;
    };
};