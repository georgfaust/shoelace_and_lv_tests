// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

SL_DEFAULTS = {
    "SL-BUTTON": { "variant": "default", "size": "medium" },
    "SL-AVATAR": { "shape": "circle" },
    "SL-BADGE": { "variant": "neutral" },
    // "@aria-hidden"! does LV mess up aria?
    "SL-ICON": { "library": "default" }
}

let liveSocket = new LiveSocket("/live", Socket, {
    params: { _csrf_token: csrfToken },
    dom: {
        onBeforeElUpdated(from, to) {
            const sl_defaults_for_current = SL_DEFAULTS[to.tagName];
            if (sl_defaults_for_current) {
                Object.entries(sl_defaults_for_current).forEach(([key, value]) => {
                    if (!to.hasAttribute(key)) {
                        to.setAttribute(key, value);
                    }
                });
            }

            if (to.tagName === "P") {
                console.log(from.dataset.counter, to.dataset.counter)
            }

        }
    }
})


window.addEventListener("sl-after-show", (evt) => {
    liveSocket.execJS(evt.target, '[["set_attr", {"attr": ["open", true]}]]');
})

window.addEventListener("sl-after-hide", (evt) => {
    liveSocket.execJS(evt.target, '[["remove_attr", {"attr": "open"}]]');
})

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

window.liveSocket = liveSocket

