from app.services.crud.models import info_system_crud
from app.main import app

from starlette.testclient import TestClient


client = TestClient(app)


def test_create_info_system_success(client):
    body = {"name": "Test Info System", "description": "This is a test info system"}
    response = client.post("/create", json=body)
    assert response.status_code == 201

def test_create_info_system_invalid_request_body(client):
    body = {"invalid": "field"}
    response = client.post("/create", json=body)
    assert response.status_code == 422

def test_create_info_system_internal_server_error(client, monkeypatch):
    def mock_create(db, obj_in):
        raise Exception("Database error")
    monkeypatch.setattr(info_system_crud, "create", mock_create)
    body = {"name": "Test Info System", "description": "This is a test info system"}
    response = client.post("/create", json=body)
    assert response.status_code == 500
    assert response.json()["detail"] == "Database error"