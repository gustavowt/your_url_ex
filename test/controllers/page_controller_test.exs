defmodule UrlShortner.PageControllerTest do
  use UrlShortner.ConnCase

  alias UrlShortner.Url

  test "GET /:id redirect to given url", %{conn: conn} do
    url = Repo.insert! %Url{ clicks: 20, original_url: "http://yahoo.com", url_hash: "AA223344" }

    conn = get conn, "/#{url.url_hash}"

    assert redirected_to(conn) ==  "http://yahoo.com"
  end

  test 'GET /:id redirect even incomplete url', %{conn: conn} do
    url = Repo.insert! %Url{ clicks: 20, original_url: "yahoo.com", url_hash: "AA223344" }

    conn = get conn, "/#{url.url_hash}"

    assert redirected_to(conn) ==  "http://yahoo.com"
  end

  test 'GET /:id renders page not found when id is not found', %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, "/AAVVCC"
    end
  end
end
