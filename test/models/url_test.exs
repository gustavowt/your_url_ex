defmodule UrlShortner.UrlTest do
  use UrlShortner.ModelCase

  alias UrlShortner.Url

  @valid_attrs %{original_url: "some content", short_url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Url.changeset(%Url{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Url.changeset(%Url{}, @invalid_attrs)
    refute changeset.valid?
  end
end
