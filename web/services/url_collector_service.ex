defmodule YourUrlEx.UrlCollectorService do
  alias YourUrlEx.Url
  alias YourUrlEx.CacheService
  alias YourUrlEx.Repo

  def get_url(url_hash) do
    url_cached = get_cached_url(url_hash)

    original_url =
      if is_nil(url_cached) do
        load_original_url(url_hash)
      else
        url_cached
      end

    original_url
  end

  defp get_cached_url(url_hash) do
    CacheService.get(url_hash)
  end

  defp load_original_url(url_hash) do
    url = Repo.get_by(Url, url_hash: url_hash)

    if url do
      CacheService.set(url.url_hash, url.original_url)

      url.original_url
    end
  end
end
