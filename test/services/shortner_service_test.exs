defmodule YourUrlEx.ShortnerServiceTest do
  use YourUrlEx.ConnCase

  test "#create_short_url, create a new url entry" do
    params = %{ "original_url" => "http://www.pudim.com.br" }

    { :ok, url } = YourUrlEx.ShortnerService.create_short_url(params)

    assert url.clicks == 0
    assert url.url_hash != nil
    assert url.original_url == "http://www.pudim.com.br"

    assert url.original_url == YourUrlEx.CacheService.get(url.url_hash)
  end
end
