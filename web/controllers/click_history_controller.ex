defmodule YourUrlEx.ClickHistoryController do
  use YourUrlEx.Web, :controller
  alias YourUrlEx.ClickHistoriesCollectorService

  def show(conn, %{"id" => url_hash}) do
    case ClickHistoriesCollectorService.all(url_hash) do
      {:ok, click_histories} ->
        render(conn, "show.json", click_histories: click_histories)
      {:error, :not_found} ->
        send_resp(conn, :not_found, "")
    end
  end
end
