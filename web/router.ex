defmodule Listen.Router do
  use Listen.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Listen do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
  end

  scope "/api", Listen do
    pipe_through :api
    post "/play", PlayController, :play
  end
end
