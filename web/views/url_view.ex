defmodule UrlShortner.UrlView do
  use UrlShortner.Web, :view

  def render("index.json", %{urls: urls}) do
    %{data: render_many(urls, UrlShortner.UrlView, "url.json")}
  end

  def render("show.json", %{url: url}) do
    %{data: render_one(url, UrlShortner.UrlView, "url.json")}
  end

  def render("url.json", %{url: url}) do
    %{clicks: url.clicks,
      original_url: url.original_url,
      short_url: "http://short_url/#{url.url_hash}"}
  end
end
