defmodule UrlShortner.PageController do
  use UrlShortner.Web, :controller

  alias UrlShortner.Url
  alias UrlShortner.UrlParserService

  require Exq

  def show(conn, %{ "id" => url_hash }) do
    url = Repo.get_by!(Url, url_hash: url_hash)

    case url do
      nil ->
        conn
        |> put_status(:unprocessable_entity)
      _ ->
        Exq.enqueue(Exq, "default", UrlShortner.UrlScrapperWorker, [url_hash])
        url_parsed = UrlShortner.UrlParserService.parse_url(url.original_url)

        conn
        |> redirect(external: url_parsed)
    end
  end
end
