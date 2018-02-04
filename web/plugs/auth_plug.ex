defmodule YourUrlEx.AuthPlug do
  @behaviour Plug
  import Plug.Conn

  require Logger

  @token_salt System.get_env("AUTHORIZATION_TOKEN_SALT")

  def init(opts), do: opts

  def call(conn, opts) do
    conn
    |> get_auth_headers
    |> authenticate
  end

  def get_auth_headers(conn) do
    {conn, Plug.Conn.get_req_header(conn, "token")}
  end

  def authenticate({conn, [token]}) do
    case Phoenix.Token.verify(YourUrlEx.Endpoint, @token_salt, token) do
      {:ok, account} ->
        conn
      {:error, :invalid} ->
        log_error(token)
        conn |> not_authorized
    end
  end

  def authenticate({conn, _}) do
    conn |> not_authorized
  end

  def not_authorized(conn) do
    conn
    |> Plug.Conn.send_resp(401, "Not Authorised")
    |> Plug.Conn.halt
  end

  def log_error(token) do
    Logger.warn fn ->
      "[AuthError] - Unable to authenticate with token: #{token}"
    end
  end
end
