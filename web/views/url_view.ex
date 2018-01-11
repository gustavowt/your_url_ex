defmodule YourUrlEx.UrlView do
  use YourUrlEx.Web, :view

  def render("index.json", %{urls: urls}) do
    %{data: render_many(urls, YourUrlEx.UrlView, "url.json")}
  end

  def render("show.json", %{url: url}) do
    %{data: render_one(url, YourUrlEx.UrlView, "url.json")}
  end

  def render("url.json", %{url: url}) do
    %{clicks: url.clicks,
      original_url: url.original_url,
      short_url: "#{YourUrlEx.Endpoint.url}/#{url.url_hash}"}
  end
end
