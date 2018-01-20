defmodule YourUrlEx.ClickHistoryView do
  use YourUrlEx.Web, :view

  def render("show.json", %{click_histories: click_histories}) do
    %{data: render_many(click_histories, YourUrlEx.ClickHistoryView, "click_history.json")}
  end

  def render("click_history.json", %{click_history: click_history}) do
    %{platform: click_history.platform,
      browser_name: click_history.browser_name,
      browser_version: click_history.browser_version,
      device: click_history.device,
      inserted_at: NaiveDateTime.to_string(click_history.inserted_at)}
  end
end
