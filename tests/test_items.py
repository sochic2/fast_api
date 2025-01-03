from fastapi.testclient import TestClient
from app.main import app
client = TestClient(app)

def test_get_items():
    response = client.get("/api/question/list")
    assert response.status_code == 200
