defmodule UrlShortner.Repo.Migrations.CreateUrl do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :original_url, :string
      add :url_hash, :string, unique: true
      add :clicks, :integer

      timestamps()
    end

  end
end
