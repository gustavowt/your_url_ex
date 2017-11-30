defmodule UrlShortner.PageController do
  use UrlShortner.Web, :controller

  alias UrlShortner.Url

  def show(conn, %{ "id" => url_hash }) do
    url = Repo.get_by!(Url, url_hash: url_hash)
    clicks = url.clicks + 1

    changeset = Url.changeset(url, %{ clicks: clicks })

    case Repo.update(changeset) do
      {:ok, url} ->
        conn
        |> redirect(external: url.original_url)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(UrlShortner.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
