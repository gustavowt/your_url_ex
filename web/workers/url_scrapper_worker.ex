defmodule UrlShortner.UrlScrapperWorker do
  alias UrlShortner.Url
  alias UrlShortner.Repo

  def perform(url_hash) do
    url = Repo.get_by(Url, url_hash: url_hash)

    updated_url =
    case url do
      nil -> false
      _ ->
        clicks = url.clicks + 1

        changeset = Url.changeset(url, %{ clicks: clicks })

        Repo.update(changeset)
    end

    updated_url
  end
end
