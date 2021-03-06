defmodule FlashCardsWeb.CardController do
  use FlashCardsWeb, :controller

  alias FlashCards.Sets
  alias FlashCards.Sets.Card

  def index(conn, _params) do
    cards = Sets.list_cards()
    render(conn, "index.html", cards: cards)
  end

  def new(conn, _params) do
    changeset = Sets.change_card(%Card{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"card" => card_params}) do
    case Sets.create_card(card_params) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card created successfully.")
        |> redirect(to: Routes.card_path(conn, :show, card))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Sets.get_card!(id)
    next_id = Sets.next_card_id(id)

    render(conn, "show.html", card: card, next_id: next_id)
  end

  def edit(conn, %{"id" => id}) do
    card = Sets.get_card!(id)
    changeset = Sets.change_card(card)
    render(conn, "edit.html", card: card, changeset: changeset)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Sets.get_card!(id)

    case Sets.update_card(card, card_params) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card updated successfully.")
        |> redirect(to: Routes.card_path(conn, :show, card))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", card: card, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Sets.get_card!(id)
    {:ok, _card} = Sets.delete_card(card)

    conn
    |> put_flash(:info, "Card deleted successfully.")
    |> redirect(to: Routes.card_path(conn, :index))
  end
end
