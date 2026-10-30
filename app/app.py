from flask import Flask, jsonify
import os, socket

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify(
        message="Kriti's 3-tier AWS project is live! Built with Terraform, Docker and ECS Fargate.",
        author="Kriti",
        stack=["Terraform", "Docker", "ECS Fargate", "ALB", "RDS"],
        host=socket.gethostname(),
        version=os.getenv("APP_VERSION", "v1"),
    )

@app.route("/health")
def health():
    return jsonify(status="ok"), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)