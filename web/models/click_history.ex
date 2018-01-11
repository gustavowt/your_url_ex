defmodule YourUrlEx.ClickHistory do
  use YourUrlEx.Web, :model

  schema "click_histories" do
    field :platform, :string
    field :browser_name, :string
    field :browser_version, :string
    field :device, :string

    belongs_to :url, YourUrlEx.Url

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:platform, :browser_name, :browser_version, :device, :url_id])
    |> validate_required([:url_id])
  end
end
