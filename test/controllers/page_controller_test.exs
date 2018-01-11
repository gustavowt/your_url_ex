defmodule UrlShortner.PageControllerTest do
  use UrlShortner.ConnCase

  alias UrlShortner.Url

  @chrome_agent "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.99 Safari/533.4"

  test "GET /:id redirect to given url", %{conn: conn} do
    url = Repo.insert! %Url{ clicks: 20, original_url: "http://yahoo.com", url_hash: "AA223344" }

    conn = put_req_header(conn, "user-agent", @chrome_agent)
    conn = get(conn, "/#{url.url_hash}")

    assert redirected_to(conn) ==  "http://yahoo.com"
  end

  test 'GET /:id redirect even incomplete url', %{conn: conn} do
    url = Repo.insert! %Url{ clicks: 20, original_url: "yahoo.com", url_hash: "AA223344" }

    conn = put_req_header(conn, "user-agent", @chrome_agent)
    conn = get(conn, "/#{url.url_hash}")

    assert redirected_to(conn) ==  "http://yahoo.com"
  end

  test 'GET /:id renders page not found when id is not found', %{conn: conn} do
    conn = get(conn, "/AAVVCC")

    assert conn.status == 404
  end
end
