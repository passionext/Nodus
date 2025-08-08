/**
 * Fetches data from the /system API and updates the dashboard.
 */
async function updateStats() {
    try {
        const response = await fetch('/system');
        if (!response.ok) {
            throw new Error(`API request failed: ${response.status}`);
        }
        const data = await response.json();

        // Update CPU Section
        document.getElementById('cpu-usage').textContent = data.cpu_usage || 'N/A';

        // Update RAM Section
        document.getElementById('ram-total').textContent = data.total_memory || 'N/A';
        document.getElementById('ram-used').textContent = data.used_memory || 'N/A';
        document.getElementById('ram-available').textContent = data.available_memory || 'N/A';

        // Update Disk Section
        document.getElementById('disk-total').textContent = data.total_disk || 'N/A';
        document.getElementById('disk-free').textContent = data.free_disk || 'N/A';
        document.getElementById('disk-percentage').textContent = data.percentage_disk || 'N/A';

    } catch (error) {
        console.error("Error fetching or updating stats:", error);
        // Display an error message in the UI
        document.querySelectorAll('li[id]').forEach(el => {
            el.textContent = 'Error';
            el.style.color = 'red';
        });
    }
}

// 1. Run the function on page load to get initial data.
updateStats();

// 2. Set an interval to refresh the data every 5 seconds.
setInterval(updateStats, 5000);
