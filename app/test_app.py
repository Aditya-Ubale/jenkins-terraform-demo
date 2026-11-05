from app import add, is_even, app


def test_add():
    assert add(2, 3) == 5


def test_add_negative():
    assert add(-1, 1) == 0


def test_is_even():
    assert is_even(4) is True
    assert is_even(7) is False


def test_home_endpoint():
    resp = app.test_client().get("/")
    assert resp.status_code == 200
    assert resp.get_json()["prn"] == "202301040111"


def test_health_endpoint():
    resp = app.test_client().get("/health")
    assert resp.get_json() == {"status": "healthy"}
