defmodule UrlShortner.ClickHistoryCreatorWorker do
  alias UrlShortner.ClickHistory
  alias UrlShortner.Repo
  alias UrlShortner.Url

  require Logger

  def perform(url_hash, platform, browser_name, browser_version, device) do
    url = Repo.get_by!(Url, url_hash: url_hash)

    changeset = ClickHistory.changeset(%ClickHistory{}, %{ url_id: url.id,
                                                           platform: platform,
                                                           browser_name: browser_name,
                                                           browser_version: browser_version,
                                                           device: device })

    case Repo.insert(changeset) do
      { :ok, click_history } ->
        { :ok, click_history }
      { :error, changeset } ->
        log_error(changeset)
        { :error, changeset }
    end
  end

  def log_error(changeset) do
    Logger.warn fn ->
      "[ClickHistoryError] - Unable to save a ClickHistory: #{inspect(changeset)}"
    end
  end
end
