defmodule YourUrlEx.ClickHistoryCreatorWorkerTest do
  use YourUrlEx.ConnCase, async: false
  alias YourUrlEx.Repo
  alias YourUrlEx.Url

  test "#perform, create a ClickHistory" do
    url = Repo.insert!(%Url{ original_url: "yahoo.com", url_hash: "AABBCC", clicks: 2 })
    browser_name = "Firefox"
    browser_version = "5.0.55"
    device = Atom.to_string(:desktop)
    platform = "Mac Os"

    { :ok, click_history } = YourUrlEx.ClickHistoryCreatorWorker.perform(url.url_hash,
                                                                           platform,
                                                                           browser_name,
                                                                           browser_version,
                                                                           device)

    assert click_history
  end
end
