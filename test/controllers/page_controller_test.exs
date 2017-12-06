defmodule UrlShortner.PageControllerTest do
  use UrlShortner.ConnCase

  alias UrlShortner.Url

  test "GET /", %{conn: conn} do
    url = Repo.insert! %Url{ clicks: 20, original_url: "http://yahoo.com", url_hash: "AA223344" }

    conn = get conn, "/", id: url.url_hash
    assert redirected_to(conn) ==  "http://yahoo.com"

    assert Repo.get(url.id).clicks == 21
  end
end
