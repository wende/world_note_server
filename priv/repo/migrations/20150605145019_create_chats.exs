defmodule WorldNote.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :fbid, :bigint
      add :latitude, :float
      add :longitude, :float
      add :content, :string
      add :fullname

      timestamps
    end

  end
end
