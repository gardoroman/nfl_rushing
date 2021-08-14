// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html";
import {Socket} from "phoenix";
import topbar from "topbar";
import {LiveSocket} from "phoenix_live_view";

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"});
window.addEventListener("phx:page-loading-start", info => topbar.show());
window.addEventListener("phx:page-loading-stop", info => topbar.hide());

/**
 * downloadCsv
 * Creates download link, appends link to document, and automatically downloads file
 */
const downloadCsv = (csv, filename) =>  {
    let csvFile = new Blob([csv], {type: "text/csv"});

    let downloadLink = document.createElement("a");

    downloadLink.download = filename;

    downloadLink.href = window.URL.createObjectURL(csvFile);

    downloadLink.style.display = "none";

    document.body.appendChild(downloadLink);

    downloadLink.click();
};

/**
 * createCsV
 * Generates CSV data from HTML table and calls download function.
 */
const createCsV = (statsTable, filename) => {
	let csv = [];
	let rows = statsTable.querySelectorAll("tr");
	
    for (let i = 0; i < rows.length; i++) {
		let row = [], cols = rows[i].querySelectorAll("td, th");
		
        for (let j = 0; j < cols.length; j++) 
            row.push(cols[j].innerText);
        
		csv.push(row.join(","));		
	}

    downloadCsv(csv.join("\n"), filename);
};

/**
 * downloadHtmlTable
 * Click handler for download button. Calls functions that generates CSV.
 */
const downloadHtmlTable = () => {
    const statsTable = document.getElementById("stats-table");
	createCsV(statsTable, "stats.csv");
};

let hooks = {};

hooks.DownloadCSV = {
    mounted(){
        let button = document.getElementById('download-btn');
        button.addEventListener('click', downloadHtmlTable);
    }
};

let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks});


// connect if there are any LiveViews on the page
liveSocket.connect();
// liveSocket.enableDebug()
// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;

