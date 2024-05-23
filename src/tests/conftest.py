import pytest
import logging
from starlette.testclient import TestClient
from app.main import app


@pytest.fixture(scope="module")
def test_app():
    logging.getLogger().setLevel(logging.WARNING)

    client = TestClient(app)
    yield client  # testing happens here