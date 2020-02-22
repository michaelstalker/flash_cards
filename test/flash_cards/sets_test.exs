defmodule FlashCards.SetsTest do
  use FlashCards.DataCase

  alias FlashCards.Sets

  describe "cards" do
    alias FlashCards.Sets.Card

    @valid_attrs %{answer: "some answer", question: "some question"}
    @update_attrs %{answer: "some updated answer", question: "some updated question"}
    @invalid_attrs %{answer: nil, question: nil}

    def card_fixture(attrs \\ %{}) do
      {:ok, card} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sets.create_card()

      card
    end

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Sets.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Sets.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      assert {:ok, %Card{} = card} = Sets.create_card(@valid_attrs)
      assert card.answer == "some answer"
      assert card.question == "some question"
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sets.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      assert {:ok, %Card{} = card} = Sets.update_card(card, @update_attrs)
      assert card.answer == "some updated answer"
      assert card.question == "some updated question"
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Sets.update_card(card, @invalid_attrs)
      assert card == Sets.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Sets.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Sets.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Sets.change_card(card)
    end
  end
end
