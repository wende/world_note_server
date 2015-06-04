defmodule WorldNote.ChatsTest do
  use WorldNote.ModelCase

  alias WorldNote.Chats

  @valid_attrs %{content: "some content", fbid: 42, latitude: "120.5", longitude: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Chats.changeset(%Chats{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Chats.changeset(%Chats{}, @invalid_attrs)
    refute changeset.valid?
  end
end
