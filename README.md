Nodus: System & Network Monitoring DashboardNodus is a lightweight, real-time monitoring solution for Linux servers, built with a Python Flask backend and a clean, dynamic frontend. It provides two distinct web dashboards for at-a-glance insights into core system and network performance metrics.Repository: https://github.com/passionext/NodusFeaturesNodus offers two specialized dashboards that update automatically every 5 seconds:📊 System Stats Dashboard (/dashboard)Live CPU Usage: A snapshot of the current user and system CPU load.Detailed RAM Overview: Displays total, used, and available memory in GB.Comprehensive Disk Usage: Shows total disk space, free space, and the aggregated percentage of used space across all mounted filesystems.🌐 Network Stats Dashboard (/network-dashboard)IP Address Discovery: Clearly shows the server's primary private and public IP addresses.Connectivity Check: Measures and displays the ping latency to a public DNS server (8.8.8.8).Open Ports Listing: Lists all unique TCP and UDP ports currently in a listening state.Tech Stack & Project StructureThe application uses a simple yet powerful stack, separating backend logic from frontend presentation.Backend: Python 3, FlaskFrontend: HTML, CSS, Vanilla JavaScriptData Collection: Bash scripts (stats.sh, network.sh) using standard Linux command-line tools (top, free, df, ss, curl, ping)..
├── main.py              # The main Flask server application
├── stats.sh             # Script to collect system stats
├── network.sh           # Script to collect network stats
│
├── templates/
│   ├── dashboard.html   # HTML for the System Stats dashboard
│   └── network.html     # HTML for the Network Stats dashboard
│
└── static/
    ├── dashboard.css      # Shared stylesheet for both dashboards
    ├── stats.js           # JavaScript for the System Stats dashboard
    └── network_stats.js   # JavaScript for the Network Stats dashboard
Getting StartedFollow these instructions to set up and run Nodus on your Linux server.1. PrerequisitesPython 3 and pip must be installed.The following command-line tools must be available: top, free, df, ss, curl, ping.2. Clone the RepositoryClone the Nodus repository to your server.git clone [https://github.com/passionext/Nodus.git](https://github.com/passionext/Nodus.git)
cd Nodus
3. Install DependenciesInstall the required Python libraries from requirements.txt.pip install -r requirements.txt
4. Make Scripts ExecutableGrant execution permissions to the data-gathering scripts.chmod +x stats.sh network.sh
5. Configure Script PathsThe main.py file contains absolute paths to the .sh scripts. This is the most common point of failure.IMPORTANT: Open main.py and update the paths to stats.sh and network.sh to match their location on your system. Using relative paths (e.g., ["bash", "network.sh"]) is recommended if the scripts are in the same directory as main.py.6. Run the ApplicationStart the Flask server using the Flask CLI.# Set the FLASK_APP environment variable
export FLASK_APP=main.py

# Run the development server
flask run --host=0.0.0.0 --port=5000
The server will now be running and accessible on port 5000.UsageOnce the server is running, access the dashboards in your web browser:System Stats: http://<your-server-ip>:5000/dashboardNetwork Stats: http://<your-server-ip>:5000/network-dashboardDisclaimerThe visual design (HTML and CSS) of this project was created using a pre-existing dashboard template. This template was then adapted and customized with the assistance of AI to integrate the specific data and features required for the Nodus application.
