defmodule UrlShortner.UrlCollectorServiceTest do
  use UrlShortner.ConnCase
  alias UrlShortner.UrlCollectorService
  alias UrlShortner.CacheService
  alias UrlShortner.Repo
  alias UrlShortner.Url

  test "#get_url, should load Url from cache" do
    CacheService.set("AABBCC", "http://pudim.com")

    assert UrlCollectorService.get_url("AABBCC") == "http://pudim.com"
  end

  test "#get_url, should load Url from Repo and set the cache" do
    url = Repo.insert! %Url{ clicks: 20, original_url: "http://yahoo.com", url_hash: "AA223344" }

    assert UrlCollectorService.get_url("AA223344") == "http://yahoo.com"
    assert CacheService.get("AA223344") == "http://yahoo.com"
  end

  test "#get_url, should return nil when url is not found" do
    refute UrlCollectorService.get_url("112243")
  end
end
