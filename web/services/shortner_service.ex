defmodule YourUrlEx.ShortnerService do
  alias YourUrlEx.Url
  alias YourUrlEx.Repo
  alias UUID

  alias YourUrlEx.CacheService

  def create_short_url(url_params) do

    case create_url(url_params) do
      { :ok, result } ->
        update_redix(result)
        { :ok, result }
      { :error, changeset } ->
        { :error, changeset }
    end
  end

  def generate_salted_id do
    UUID.uuid4(:hex)
    |> String.slice(0..10)
  end

  def update_redix(url) do
    CacheService.set(url.url_hash, url.original_url)
  end

  def create_url(url_params) do
    uuid = generate_salted_id()
    params = Map.put(url_params, "url_hash", uuid)
    params = Map.put(params, "clicks", 0)

    changeset = Url.changeset(%Url{}, params)

    Repo.insert(changeset)
  end
end
