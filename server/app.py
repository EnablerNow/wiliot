from flask import Flask, jsonify
from datetime import datetime
import pytz

app = Flask(__name__)

@app.route('/')
def show_time():
    time_zones = {
        'New York': 'America/New_York',
        'Berlin': 'Europe/Berlin',
        'Tokyo': 'Asia/Tokyo'
    }
    times = {region: datetime.now(pytz.timezone(tz)).strftime('%Y-%m-%d %H:%M:%S') for region, tz in time_zones.items()}
    return f"<html><body>{'<br>'.join([f'{region}: {time}' for region, time in times.items()])}</body></html>"

@app.route('/health')
def health():
    return jsonify(status="healthy"), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
