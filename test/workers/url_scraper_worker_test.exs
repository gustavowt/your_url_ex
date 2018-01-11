defmodule YourUrlEx.UrlScraperWorkerTest do
  use YourUrlEx.ConnCase, async: false
  alias YourUrlEx.Url
  alias YourUrlEx.Repo

  @valid_attrs %Url{ original_url: "yahoo.com", url_hash: "AABBCC", clicks: 2 }

  test "#perfom, increment url info" do
    url = Repo.insert!(@valid_attrs)

    { :ok, updated_url } = YourUrlEx.UrlScraperWorker.perform(url.url_hash)

    assert 3 == updated_url.clicks
  end
end
