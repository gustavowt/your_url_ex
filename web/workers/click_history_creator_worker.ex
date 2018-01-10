defmodule UrlShortner.ClickHistoryCreatorWorker do
  alias UrlShortner.ClickHistory
  alias UrlShortner.Repo

  require Logger

  def perform(url_id, platform, browser_name, browser_version, device) do
    changeset = ClickHistory.changeset(%ClickHistory{}, %{ url_id: url_id,
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
