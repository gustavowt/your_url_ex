defmodule YourUrlEx.ClickHistoryControllerTest do
  use YourUrlEx.ConnCase

  alias YourUrlEx.Url
  alias YourUrlEx.ClickHistory
  @token Phoenix.Token.sign(YourUrlEx.Endpoint, System.get_env("AUTHORIZATION_TOKEN_SALT"), "DarthVader")

  setup %{conn: conn} do
    conn = conn
           |> put_req_header("accept", "application/json")
           |> put_req_header("token", @token)

    {:ok, conn: conn}
  end

  test "GET /:id render the history of URL", %{conn: conn} do
    url = Repo.insert! %Url{ clicks: 20, original_url: "http://yahoo.com", url_hash: "AA223344" }

    history_1 = Repo.insert! %ClickHistory{
      url_id: url.id,
      platform: "MacOs",
      browser_name: "Chrome",
      browser_version: "1.0.1",
      device: "desktop" }
    history_2 = Repo.insert! %ClickHistory{
      url_id: url.id,
      platform: "windows",
      browser_name: "Mozilla",
      browser_version: "2.3",
      device: "linux" }

    conn = get conn, click_history_path(conn, :show, %ClickHistory{id: url.url_hash})

    assert json_response(conn, 200)["data"] == [
      %{"platform" => "windows",
        "browser_name" => "Mozilla",
        "browser_version" => "2.3",
        "device" => "linux",
        "inserted_at" => NaiveDateTime.to_string(history_2.inserted_at)},
      %{"platform" => "MacOs",
        "browser_name" => "Chrome",
        "browser_version" => "1.0.1",
        "device" => "desktop",
        "inserted_at" => NaiveDateTime.to_string(history_1.inserted_at)},
    ]
  end

  test 'GET /:id renders page not found when id is not found', %{conn: conn} do
    conn = get conn, click_history_path(conn, :show, %ClickHistory{id: "AABBVV"})

    assert conn.status == 404
  end

  test "renders page not found when token is invalid", %{conn: conn} do
    conn = conn |> put_req_header("token", "notAValidToken")

    conn = get(conn, url_path(conn, :index))

    assert conn.status == 401
    assert conn.resp_body == "Not Authorised"
  end
end
