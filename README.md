# Nodus: System & Network Monitoring Dashboard

**Nodus** is a lightweight, real-time monitoring solution for Linux servers, featuring a Python Flask backend and a clean, dynamic frontend.  
It provides **two separate dashboards** for quick insights into **system** and **network** performance.

**Repository:** [https://github.com/passionext/Nodus](https://github.com/passionext/Nodus)

---

## ✨ Features

Nodus updates its dashboards automatically every **5 seconds**.

### 📊 System Stats Dashboard (`/dashboard`)
- **Live CPU Usage** – Displays current user and system CPU load.
- **Detailed RAM Overview** – Shows total, used, and available memory in GB.
- **Comprehensive Disk Usage** – Total capacity, free space, and aggregated % used across all mounted filesystems.

### 🌐 Network Stats Dashboard (`/network-dashboard`)
- **IP Address Discovery** – Shows primary private and public IP addresses.
- **Connectivity Check** – Measures ping latency to a public DNS server (`8.8.8.8`).
- **Open Ports Listing** – Lists all unique TCP/UDP ports currently in a listening state.

---

## 🛠 Tech Stack

**Backend:** Python 3, Flask  
**Frontend:** HTML, CSS, Vanilla JavaScript  
**Data Collection:** Bash scripts (`stats.sh`, `network.sh`) using `top`, `free`, `df`, `ss`, `curl`, `ping`

---

## 📂 Project Structure

```
.
├── main.py              # Main Flask application
├── stats.sh             # Collects system stats
├── network.sh           # Collects network stats
│
├── templates/
│   ├── dashboard.html   # System Stats dashboard
│   └── network.html     # Network Stats dashboard
│
└── static/
    ├── dashboard.css      # Shared stylesheet
    ├── stats.js           # System Stats dashboard logic
    └── network_stats.js   # Network Stats dashboard logic
```

---

## 🚀 Getting Started

### 1. Prerequisites
- Python 3 + `pip`
- Linux command-line tools: `top`, `free`, `df`, `ss`, `curl`, `ping`

### 2. Clone the Repository
```bash
git clone https://github.com/passionext/Nodus.git
cd Nodus
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Make Scripts Executable
```bash
chmod +x stats.sh network.sh
```

### 5. Configure Script Paths
In `main.py`, ensure paths to `stats.sh` and `network.sh` are correct.  
Relative paths (e.g., `["bash", "network.sh"]`) are recommended if scripts are in the same directory as `main.py`.

### 6. Run the Application
```bash
export FLASK_APP=main.py
flask run --host=0.0.0.0 --port=5000
```
The server will be available at: `http://<your-server-ip>:5000`

---

## 💻 Usage

- **System Stats:** `http://<your-server-ip>:5000/dashboard`  
- **Network Stats:** `http://<your-server-ip>:5000/network-dashboard`

---

## 📜 Disclaimer
The HTML/CSS template was adapted from a pre-existing dashboard design.  
It was customized with the help of AI to integrate the specific data and features for Nodus.
