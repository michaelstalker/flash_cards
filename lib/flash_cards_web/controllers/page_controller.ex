defmodule FlashCardsWeb.PageController do
  use FlashCardsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
