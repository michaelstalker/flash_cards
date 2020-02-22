defmodule FlashCards.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :question, :string
      add :answer, :string

      timestamps()
    end

  end
end
