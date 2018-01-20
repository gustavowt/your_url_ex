defmodule YourUrlEx.ClickHistoriesCollectorService do
  alias YourUrlEx.Repo
  alias YourUrlEx.ClickHistory
  alias YourUrlEx.Url

  import Ecto.Query

  def all(url_hash) do
    url = Repo.get_by(Url, url_hash: url_hash)

    if url do
      query = from ch in ClickHistory,
        where: ch.url_id == ^url.id,
        order_by: [desc: ch.inserted_at],
        select: ch

      click_histories = query |> Repo.all

      {:ok, click_histories}
    else
      {:error, :not_found}
    end
  end
end
