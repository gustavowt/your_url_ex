defmodule YourUrlEx.UrlParserService do
  require URI

  def parse_url(url) do
    uri = URI.parse(url)

    uri =
    case uri.scheme do
      nil ->
        path = uri.path
        %{ uri | scheme: "http", authority: path, host: path, port: 80, path: nil}
      _ -> # _ means ELSE
        uri
    end

    URI.to_string(uri)
  end
end
