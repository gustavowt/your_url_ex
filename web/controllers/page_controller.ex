defmodule UrlShortner.PageController do
  use UrlShortner.Web, :controller

  alias UrlShortner.Url
  alias UrlShortner.UrlParserService
  alias Browser

  require Exq

  def show(conn, %{ "id" => url_hash }) do
    url = Repo.get_by!(Url, url_hash: url_hash)

    case url do
      nil ->
        conn
        |> put_status(:unprocessable_entity)
      _ ->

        scratch_url(url_hash)
        collect_connection_info(conn, url.id)
        url_parsed = UrlShortner.UrlParserService.parse_url(url.original_url)

        conn
        |> redirect(external: url_parsed)
    end
  end

  defp collect_connection_info(conn, url_id) do
    browser_name = Browser.name(conn)
    browser_version = Browser.full_version(conn)
    platform = Browser.full_platform_name(conn)
    device = Browser.device_type(conn) |> Atom.to_string

    Exq.enqueue(Exq, "default", UrlShortner.ClickHistoryCreatorWorker, [url_id,
                                                                        platform,
                                                                        browser_name,
                                                                        browser_version,
                                                                        device])
  end

  defp scratch_url(url_hash) do
    Exq.enqueue(Exq, "default", UrlShortner.UrlScraperWorker, [url_hash])
  end
end
