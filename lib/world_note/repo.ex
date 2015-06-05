defmodule WorldNote.Repo do
  use Ecto.Repo, otp_app: :world_note

  schema "chats" do
    add :fbid, :integer
    add :latitude, :float
    add :longitude, :float
    add :content, :string

    timestamps
  end
end
