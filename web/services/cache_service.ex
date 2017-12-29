defmodule UrlShortner.CacheService do
  alias Redix

  def get(key) do
    {:ok, result } = Redix.command(connection(), ["GET", key])

    result
  end

  def set(key, value) do
    {:ok, result } = Redix.command(connection(), ["SET", key, value])

    result
  end

  def connection do
    { :ok, conn } = Redix.start_link()

    conn
  end
end
