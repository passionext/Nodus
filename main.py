import os
import subprocess
import json
from flask import Flask, jsonify, Response, render_template
from flask_cors import CORS

SCRIPT = "/home/passionextforcloud/stats.sh"


app = Flask(__name__)
CORS(app)


@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"


@app.route("/dashboard")
def dashboard():
    return render_template("dashboard.html")

@app.route("/system")
def run_script():
    result = subprocess.run(
            ["bash", SCRIPT],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
            )
    if result.returncode != 0:
        return jsonify({"error": result.stderr.strip()}), 500
    try:
        data = json.loads(result.stdout.strip())
        return jsonify(data)
    except json.JSONDecodeError:
        return jsonify({"error": "Invalid JSON output from script"}), 500


@app.route('/network')
def network_dashboard():
    """Renders the new network stats dashboard."""
    return render_template('network.html')

@app.route("/netstats")
def run_network_script():

    result = subprocess.run(
            ["bash", "/home/passionextforcloud/network.sh"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
            )
    if result.returncode != 0:
        return jsonify({"error": result.stderr.strip()}), 500
    try:
        data = json.loads(result.stdout.strip())
        return jsonify(data)
    except json.JSONDecodeError:
        return jsonify({"error": "Invalid JSON output from script"}), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

