import os
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello DevOps v2 from Salesforce Mini-Platform!I like indian and thai and bbq food."

@app.route("/healthz")
def healthz():
    return jsonify(status="ok", service="hello-devops-sf"), 200

if __name__ == "__main__":
    # Flask’s built-in server for a simple demo
    # Use 127.0.0.1 for development, 0.0.0.0 for containers
    is_container = os.getenv("CONTAINER_ENV", "false").lower() == "true"
    host = "0.0.0.0" if is_container else "127.0.0.1"
    port = int(os.getenv("FLASK_PORT", "5000"))
    debug = os.getenv("FLASK_DEBUG", "False").lower() == "true"
    app.run(host=host, port=port, debug=debug)
