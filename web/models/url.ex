defmodule YourUrlEx.Url do
  use YourUrlEx.Web, :model

  schema "urls" do
    field :original_url, :string
    field :url_hash, :string
    field :clicks, :integer

    has_many :click_histories, YourUrlEx.ClickHistory

    timestamps()
  end

  @required_fields ~w(original_url url_hash)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:original_url, :url_hash, :clicks])
    |> validate_required([:original_url, :url_hash])
  end
end
