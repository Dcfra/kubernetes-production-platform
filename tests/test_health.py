import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "app")))
from app import app

def test_health_endpoint():
    client = app.test_client()
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json()["status"] == "healthy"

def test_ready_endpoint():
    client = app.test_client()
    response = client.get("/ready")
    assert response.status_code == 200
    assert response.get_json()["status"] == "ready"

def test_root_endpoint():
    client = app.test_client()
    response = client.get("/")
    assert response.status_code == 200
    assert response.get_json()["service"] == "platform-health-api"
