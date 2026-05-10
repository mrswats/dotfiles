from http import HTTPStatus
from typing import Any

import pytest
from django.urls import reverse


@pytest.fixture
def ENDPOINT_url():
    return reverse("ENDPOINT_NAME")


@pytest.fixture
def ENDPOINT_detail_url():
    def _(ITEM_id: str) -> str:
        return reverse("ENDPOINT_NAME_DETAIL")

    return _


@pytest.fixture
def list_ENDPOINT(client, ENDPOINT_url):
    def _():
        return client.get(ENDPOINT_url)

    return _


@pytest.fixture
def retrieve_ENDPOINT(client, ENDPOINT_detail_url):
    def _(ITEM_id: str):
        return client.get(ENDPOINT_detail_url(ITEM_id))

    return _


@pytest.fixture
def create_ENDPOINT(client, ENDPOINT_url):
    def _(data: dict[str, Any]):
        return client.post(ENDPOINT_url)

    return _


@pytest.fixture
def update_ENDPOINT(client, ENDPOINT_detail_url):
    def _(ITEM_id: str, data: dict[str, Any]):
        return client.patch(ENDPOINT_detail_url(ITEM_id), data=data)

    return _


@pytest.fixture
def delete_ENDPOINT(client, ENDPOINT_detail_url):
    def _(ITEM_id: str):
        return client.delete(ENDPOINT_detail_url(ITEM_id))

    return _


def test_ENDPOINT_url(ENDPOINT_url):
    assert ENDPOINT_url == ""


def test_ENDPOINT_detail_url(ENDPOINT_detail_url):
    assert ENDPOINT_detail_url("foo") == ""


@pytest.mark.django_db
def test_ENDPOINT_list_status_code(list_ENDPOINT):
    response = list_ENDPOINT()
    assert response.status_code == HTTPStatus.OK


@pytest.mark.django_db
def test_ENDPOINT_list_unauthorized_status_code(list_ENDPOINT):
    response = list_ENDPOINT()
    assert response.status_code == HTTPStatus.UNAUTHORIZED


@pytest.mark.django_db
def test_ENDPOINT_list_data(list_ENDPOINT):
    response = list_ENDPOINT()
    assert response.json() == {}


@pytest.mark.django_db
def test_ENDPOINT_list_number_of_queries(list_ENDPOINT, django_assert_num_queries):
    with django_assert_num_queries(0):
        list_ENDPOINT()


@pytest.mark.django_db
def test_ENDPOINT_retrieve_status_code(retrieve_ENDPOINT):
    response = retrieve_ENDPOINT()
    assert response.status_code == HTTPStatus.OK


@pytest.mark.django_db
def test_ENDPOINT_retrieve_unauthorized_status_code(retrieve_ENDPOINT):
    response = retrieve_ENDPOINT()
    assert response.status_code == HTTPStatus.UNAUTHORIZED


@pytest.mark.django_db
def test_ENDPOINT_retrieve_data(retrieve_ENDPOINT):
    response = retrieve_ENDPOINT()
    assert response.json() == {}


@pytest.mark.django_db
def test_ENDPOINT_retrieve_data_number_of_queries(
    retrieve_ENDPOINT, django_assert_num_queries
):
    with django_assert_num_queries(0):
        retrieve_ENDPOINT()


@pytest.mark.django_db
def test_ENDPOINT_retrieve_create_status_code(create_ENDPOINT):
    response = create_ENDPOINT()
    assert response.status_code == HTTPStatus.OK


@pytest.mark.django_db
def test_ENDPOINT_create_unauthorized_status_code(create_ENDPOINT):
    response = create_ENDPOINT()
    assert response.status_code == HTTPStatus.UNAUTHORIZED


@pytest.mark.django_db
def test_ENDPOINT_create_data(create_ENDPOINT):
    response = create_ENDPOINT()
    assert response.json() == {}


@pytest.mark.django_db
def test_ENDPOINT_create_number_of_queries(create_ENDPOINT, django_assert_num_queries):
    with django_assert_num_queries(0):
        create_ENDPOINT()


@pytest.mark.django_db
def test_ENDPOINT_update_status_code(update_ENDPOINT):
    response = update_ENDPOINT()
    assert response.status_code == HTTPStatus.OK


@pytest.mark.django_db
def test_ENDPOINT_update_unauthorized_status_code(update_ENDPOINT):
    response = update_ENDPOINT()
    assert response.status_code == HTTPStatus.UNAUTHORIZED


@pytest.mark.django_db
def test_ENDPOINT_update_data(update_ENDPOINT):
    response = update_ENDPOINT()
    assert response.json() == {}


@pytest.mark.django_db
def test_ENDPOINT_update_data_number_of_queries(
    update_ENDPOINT, django_assert_num_queries
):
    with django_assert_num_queries(0):
        update_ENDPOINT()


@pytest.mark.django_db
def test_ENDPOINT_delete_status_code(delete_ENDPOINT):
    response = delete_ENDPOINT()
    assert response.status_code == HTTPStatus.NO_CONTENT


@pytest.mark.django_db
def test_ENDPOINT_delete_unauthorized_status_code(delete_ENDPOINT):
    response = delete_ENDPOINT()
    assert response.status_code == HTTPStatus.UNAUTHORIZED


@pytest.mark.django_db
def test_ENDPOINT_delete_number_of_queries(delete_ENDPOINT, django_assert_num_queries):
    with django_assert_num_queries(0):
        delete_ENDPOINT()
