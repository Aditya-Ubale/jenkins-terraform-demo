from flask import Flask, jsonify

app = Flask(__name__)


def add(a, b):
    return a + b


def is_even(n):
    return n % 2 == 0


@app.route("/")
def home():
    return jsonify(message="Jenkins CI/CD + Terraform demo",
                   student="Aditya Ubale", prn="202301040111")


@app.route("/health")
def health():
    return jsonify(status="healthy")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
