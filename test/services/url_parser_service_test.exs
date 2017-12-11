defmodule UrlShortner.UrlParserServiceTest do
  use ExUnit.Case, async: true

  alias UrlShortner.UrlParserService

  test "#parse_url, should parse url with scheme" do
    assert UrlParserService.parse_url("http://yahoo.com") == "http://yahoo.com"
  end

  test "#parse_url, should parse url with no scheme" do
    assert UrlParserService.parse_url("yahoo.com") == "http://yahoo.com"
  end

  test "#parse_url, should parse url with diferent protocol" do
    assert UrlParserService.parse_url("ftp://yahoo.com") == "ftp://yahoo.com"
  end
end
