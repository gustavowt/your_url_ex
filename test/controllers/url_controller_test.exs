defmodule UrlShortner.UrlControllerTest do
  use UrlShortner.ConnCase

  alias UrlShortner.Url
  @valid_attrs %{original_url: "some content", short_url: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, url_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    url = Repo.insert! %Url{}
    conn = get conn, url_path(conn, :show, url)
    assert json_response(conn, 200)["data"] == %{"id" => url.id,
      "original_url" => url.original_url,
      "short_url" => url.short_url}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, url_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, url_path(conn, :create), url: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Url, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, url_path(conn, :create), url: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    url = Repo.insert! %Url{}
    conn = put conn, url_path(conn, :update, url), url: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Url, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    url = Repo.insert! %Url{}
    conn = put conn, url_path(conn, :update, url), url: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    url = Repo.insert! %Url{}
    conn = delete conn, url_path(conn, :delete, url)
    assert response(conn, 204)
    refute Repo.get(Url, url.id)
  end
end
