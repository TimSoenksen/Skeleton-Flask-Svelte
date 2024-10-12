from flask import Flask, request, send_from_directory, jsonify, make_response
import logging
import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import pandas as pd
from datetime import datetime, timedelta

# Set up logging
logging.basicConfig(level=logging.DEBUG)

app = Flask(__name__, static_folder='frontend/build')



@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve(path):
    logging.debug(f"Requested path: {path}")
    logging.debug(f"Static folder: {app.static_folder}")
    logging.debug(f"Full path: {os.path.join(app.static_folder, path)}")
    
    if path != "" and os.path.exists(os.path.join(app.static_folder, path)):
        logging.debug(f"Serving file: {path}")
        return send_from_directory(app.static_folder, path)
    else:
        logging.debug("Serving index.html")
        return send_from_directory(app.static_folder, 'index.html')

# Set this port to whatever you decided in the dockerfile.
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=1234, debug=True)