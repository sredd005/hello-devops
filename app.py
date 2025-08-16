from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello DevOps from Salesforce Mini-Platform!"

@app.route("/healthz")
def healthz():
    return jsonify(status="ok", service="hello-devops-sf"), 200

if __name__ == "__main__":
    # Flask’s built-in server for a simple demo
    app.run(host="0.0.0.0", port=5000)
