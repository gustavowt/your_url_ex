defmodule UrlShortner.PageController do
  use UrlShortner.Web, :controller

  alias UrlShortner.Url

  alias UrlShortner.UrlParserService

  def show(conn, %{ "id" => url_hash }) do
    url = Repo.get_by!(Url, url_hash: url_hash)
    clicks = url.clicks + 1

    changeset = Url.changeset(url, %{ clicks: clicks })

    case Repo.update(changeset) do
      {:ok, url} ->
        url_parsed = UrlShortner.UrlParserService.parse_url(url.original_url)

        conn
        |> redirect(external: url_parsed)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(UrlShortner.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
