defmodule YourUrlEx.Repo.Migrations.CreateClickHistory do
  use Ecto.Migration

  def change do
    create table(:click_histories) do
      add :platform, :string
      add :browser_name, :string
      add :browser_version, :string
      add :device, :string

      add :url_id, references("urls")

      timestamps()
    end

    create index("click_histories", :url_id)
  end
end
