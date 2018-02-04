defmodule YourUrlEx.Router do
  use YourUrlEx.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug YourUrlEx.AuthPlug, repo: YourUrlEx.Repo
  end

  scope "/", YourUrlEx do
    pipe_through :browser # Use the default browser stack

    get "/:id", PageController, :show
  end

  scope "/api", YourUrlEx do
    pipe_through :api

    resources "/urls", UrlController, except: [:edit, :update]
    resources "/click_histories", ClickHistoryController, only: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", YourUrlEx do
  #   pipe_through :api
  # end
end
