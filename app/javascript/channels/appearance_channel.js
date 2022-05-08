import consumer from "channels/consumer"

// Reset function and timer for away status
let resetFunc;
let timer = 0;


consumer.subscriptions.create("AppearanceChannel", {

    initialized() {

    },

    connected() {
        // Called when the subscription is ready for use on the server
        console.log("connected");
        // Intialize the reset function
        resetFunc = () => this.resetTimer(this.uninstall);
        // Add event handlers
        this.install();
        // Add event listener for turbo load - fires once on every page load and every turbo visit
        window.addEventListener("turbo:load", () => this.resetTimer())
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
        console.log("disconnected");
        // Uninstall event listeners
        this.uninstall();
    },

    rejected() {
        console.log("rejected");
        // Uninstall event listeners
        this.uninstall();
    },

    received(data) {
        // Called when there's incoming data on the websocket for this channel
    },


    online() {
        console.log("online");
        this.perform('online');
    },

    away() {
        console.log("away");
        this.perform('away');
    },

    offline() {
        console.log("offline");
        this.perform('offline');
    },


    uninstall() {
        // Check we are on the right page
        const shouldRun = document.getElementById("appearance_channel");
        if (!shouldRun) {
            // Clear timeout
            clearTimeout(timer);
            // Perform Offline
            this.perform('offline');
        }
    },


    install() {
        console.log("install");
        // Remove any potential event listeners
        window.removeEventListener('load', resetFunc);
        window.removeEventListener('DOMContentLoaded', resetFunc);
        window.removeEventListener('click', resetFunc);
        window.removeEventListener('keydown', resetFunc);

        // Add new event listeners
        window.addEventListener('load', resetFunc);
        window.addEventListener('DOMContentLoaded', resetFunc);
        window.addEventListener('click', resetFunc);
        window.addEventListener('keydown', resetFunc);
        this.resetTimer();
    },


    resetTimer() {
        this.uninstall();
        // Check we are on correct page
        const shouldRun = document.getElementById("appearance_channel");
        if (!!shouldRun) {
            // Set status as online
            this.online();
            // Clear timer
            clearTimeout(timer);
            // Set timer in Milliseconds
            const timeInSeconds = 5;
            const milliseconds = 1000;
            const timeInMilliSeconds = timeInSeconds * milliseconds;

            timer = setTimeout(this.away.bind(this), timeInMilliSeconds);
        }
    }
});
