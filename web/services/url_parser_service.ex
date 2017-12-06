defmodule UrlShortner.UrlParserService do
  require URI

  def parse_url(url) do
    uri = URI.parse(url)
    uri =
    case uri do
      {scheme, nil} ->
        uri = %{ uri | scheme: "http" }
    end

    URI.to_string(uri)
  end
end
