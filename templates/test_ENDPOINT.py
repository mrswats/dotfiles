from http import HTTPStatus

import pytest
from django.urls import reverse


@pytest.fixture
def ENDPOINT_url():
    return reverse("ENDPOINT_NAME")


@pytest.fixture
def list_ENDPOINT(client, ENDPOINT_url):
    def _():
        return client.get(ENDPOINT_url)

    return _


def test_ENDPOINT_url(ENDPOINT_url):
    assert ENDPOINT_url == ""


@pytest.mark.django_db
def test_ENDPOINT_status_code(list_ENDPOINT):
    response = list_ENDPOINT()
    assert response.status_code == HTTPStatus.OK


@pytest.mark.django_db
def test_ENDPOINT_data(list_ENDPOINT):
    response = list_ENDPOINT()
    assert response.json() == {}
