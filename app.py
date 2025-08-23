import os
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello DevOps v2 from Salesforce Mini-Platform!I like dosa and idli and upma a lot."

@app.route("/healthz")
def healthz():
    return jsonify(status="ok", service="hello-devops-sf"), 200

if __name__ == "__main__":
    # Flask’s built-in server for a simple demo
    host = os.getenv("FLASK_HOST", "0.0.0.0")
    port = int(os.getenv("FLASK_PORT", "5000"))
    debug = os.getenv("FLASK_DEBUG", "False").lower() == "true"
    app.run(host=host, port=port, debug=debug)
