/**
 * Fetches network data and updates the dashboard.
 */
async function updateNetworkStats() {
    try {
        
        const response = await fetch('/netstats');

        if (!response.ok) {
            throw new Error(`Server error: ${response.status} ${response.statusText}`);
        }
        
        const data = await response.json(); 
        
        if (data.error) {
            throw new Error(`API returned an error: ${data.error}`);
        }

        // --- If successful, update the dashboard ---

        document.getElementById('private-ip').textContent = data.private_ip || 'N/A';
        document.getElementById('public-ip').textContent = data.public_ip || 'N/A';
        document.getElementById('latency').textContent = data.latency_ms ? `${data.latency_ms} ms` : 'N/A';

        const portsList = document.getElementById('open-ports-list');
        portsList.innerHTML = ''; 
        if (data.open_ports && data.open_ports.length > 0) {
            // CORRECTED: Looping over 'data.open_ports' instead of 'portsList'
            data.open_ports.forEach(port => {
                const li = document.createElement('li');
                li.textContent = port;
                portsList.appendChild(li);
            });
        } else {
            portsList.innerHTML = '<li>No open ports detected.</li>';
        }

    } catch (error) {
        console.error("Error fetching or updating stats:", error);
        
        let errorMessage = `Error: ${error.message}`;
        
        if (error instanceof TypeError) {
             errorMessage = 'Error: Could not connect to server. Is it running?';
        } 
        else if (error instanceof SyntaxError) {
            errorMessage = "Error: Server sent invalid data. Check server's console log.";
        }
        
        const errorElement = document.getElementById('private-ip');
        if (errorElement) {
            errorElement.textContent = errorMessage;
            errorElement.style.color = '#ff6b6b';
            errorElement.style.fontSize = '14px';
        }
        document.getElementById('public-ip').textContent = 'Please check the console for details.';
        document.getElementById('latency').textContent = '-';
        document.getElementById('open-ports-list').innerHTML = '<li>Error</li>';
    }
}

// 1. Run the function on page load to get initial data.
updateNetworkStats();

// 2. Set an interval to refresh the data every 5 seconds.
setInterval(updateNetworkStats, 5000);
