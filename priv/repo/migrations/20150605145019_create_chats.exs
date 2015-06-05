defmodule WorldNote.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :fbid, :integer
      add :latitude, :float
      add :longitude, :float
      add :content, :string

      timestamps
    end

  end
end
