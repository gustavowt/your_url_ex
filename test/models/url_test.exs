defmodule UrlShortner.UrlTest do
  use UrlShortner.ModelCase

  alias UrlShortner.Url

  @valid_attrs %{ original_url: "yahoo.com", url_hash: "AABBCC", clicks: 0 }
  @invalid_attrs %{original_url: "yahoo.com"}

  test "changeset with valid attributes" do
    changeset = Url.changeset(%Url{}, @valid_attrs)

    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Url.changeset(%Url{}, @invalid_attrs)
    refute changeset.valid?
  end
end
