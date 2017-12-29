defmodule UrlShortner.CacheServiceTest do
  use ExUnit.Case, async: true

  alias UrlShortner.CacheService

  test "#get, should get a cache provider value" do
    Redix.command(connection(), ["SET", "foo", "bar"])

    assert "bar" == CacheService.get("foo")
  end

  test "#set, should set a cache provider value" do
    CacheService.set("food", "apple")
    { :ok, result } = Redix.command(connection(), ["GET", "food"])

    assert "apple" == result
  end

  def connection do
    { :ok, conn } = Redix.start_link()

    conn
  end
end
