defmodule FlashCardsWeb.Router do
  use FlashCardsWeb, :router

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

  scope "/", FlashCardsWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/cards", CardController
  end

  # Other scopes may use custom stacks.
  # scope "/api", FlashCardsWeb do
  #   pipe_through :api
  # end
end
