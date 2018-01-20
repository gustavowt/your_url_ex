defmodule YourUrlEx.ClickHistoriesCollectorServiceTest do
  use YourUrlEx.ConnCase
  alias YourUrlEx.ClickHistoriesCollectorService
  alias YourUrlEx.Url
  alias YourUrlEx.ClickHistory
  alias YourUrlEx.Repo

  test "#all, load all click_histories form an Url" do
    url = Repo.insert! %Url{ clicks: 20, original_url: "http://yahoo.com", url_hash: "AA223344" }
    Repo.insert! %ClickHistory{
      url_id: url.id,
      platform: "MacOs",
      browser_name: "Chrome",
      browser_version: "1.0.1",
      device: "desktop" }

    {:ok, click_histories} = ClickHistoriesCollectorService.all(url.url_hash)

    assert 1 == length(click_histories)
  end
end
