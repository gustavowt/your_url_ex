defmodule UrlShortner.UrlController do
  use UrlShortner.Web, :controller
  alias UrlShortner.ShortnerService
  alias UrlShortner.Url

  def index(conn, _params) do
    urls = Repo.all(Url)
    render(conn, "index.json", urls: urls)
  end

  def create(conn, %{"url" => url_params}) do
    result = UrlShortner.ShortnerService.create_short_url(url_params)

    case result do
      {:ok, url} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", url_path(conn, :show, url))
        |> render("show.json", url: url)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(UrlShortner.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => url_hash}) do
    url = Repo.get_by!(Url, url_hash: url_hash)
    render(conn, "show.json", url: url)
  end

  def delete(conn, %{"id" => url_hash}) do
    url = Repo.get_by!(Url, url_hash: url_hash)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(url)

    send_resp(conn, :no_content, "")
  end
end
