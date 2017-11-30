defmodule UrlShortner.ShortnerService do
  alias UrlShortner.Url
  alias UrlShortner.Repo
  alias UUID
  alias Ecto.Changeset

  @salt 2976

  def create_short_url(url_params) do
    uuid = generate_salted_id()
    params = Map.put(url_params, "url_hash", uuid)
    params = Map.put(params, "clicks", 0)

    changeset = Url.changeset(%Url{}, params)

    result = Repo.insert(changeset)

    result
  end

  def generate_salted_id do
    UUID.uuid4(:hex)
    |> String.slice(0..10)
  end
end
