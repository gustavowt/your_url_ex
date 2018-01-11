defmodule YourUrlEx.ClickHistoryTest do
  use YourUrlEx.ModelCase

  alias YourUrlEx.ClickHistory

  @valid_attrs %{brownser_name: "Firfox", browser_version: "5.0.0", device: "some content", platform: "some content", url_id: 1}
  @invalid_attrs %{brownser_name: "Firfox", browser_version: "5.0.0", device: "some content", platform: "some content"}

  test "changeset with valid attributes" do
    changeset = ClickHistory.changeset(%ClickHistory{}, @valid_attrs)

    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ClickHistory.changeset(%ClickHistory{}, @invalid_attrs)
    refute changeset.valid?
  end
end
