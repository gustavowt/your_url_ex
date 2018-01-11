defmodule UrlShortner.PageController do
  use UrlShortner.Web, :controller

  alias UrlShortner.Url
  alias UrlShortner.UrlParserService
  alias UrlShortner.UrlCollectorService
  alias Browser

  require Exq

  def show(conn, %{ "id" => url_hash }) do
    url = UrlCollectorService.get_url(url_hash)

    if url do
      scratch_url(url_hash)
      collect_connection_info(conn, url_hash)
      url_parsed = UrlShortner.UrlParserService.parse_url(url)

      conn
      |> redirect(external: url_parsed)
    else
      conn
      |> send_resp(:not_found, "")
    end
  end

  defp collect_connection_info(conn, url_hash) do
    browser_name = Browser.name(conn)
    browser_version = Browser.full_version(conn)
    platform = Browser.full_platform_name(conn)
    device = Browser.device_type(conn) |> Atom.to_string

    Exq.enqueue(Exq, "default", UrlShortner.ClickHistoryCreatorWorker, [url_hash,
                                                                        platform,
                                                                        browser_name,
                                                                        browser_version,
                                                                        device])
  end

  defp scratch_url(url_hash) do
    Exq.enqueue(Exq, "default", UrlShortner.UrlScraperWorker, [url_hash])
  end
end
