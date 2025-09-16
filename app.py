from flask import Flask, send_from_directory
import os
import pyngrok
from threading import Timer

app = Flask(__name__)

@app.route('/')
def index():
    return send_from_directory('.', 'README.md')

@app.route('/<path:path>')
def serve_file(path):
    return send_from_directory('.', path)

def shutdown():
    os._exit(0)

if __name__ == '__main__':
    # Démarre le serveur Flask
    app.run(host='0.0.0.0', port=5000)

    # Configure ngrok
    ngrok_tunnel = pyngrok.ngrok.connect(5000)
    print(f" * ngrok tunnel «{ngrok_tunnel.public_url}»")

    # Ferme le tunnel après 120 secondes
    Timer(120, shutdown).start()
