defmodule WorldNote.ChatsView do
  use WorldNote.Web, :view

  def render("index.json", %{chats: chats}) do
    %{data: render_many(chats, "chats.json")}
  end

  def render("show.json", %{chats: chats}) do
    %{data: render_one(chats, "chats.json")}
  end

  def render("chats.json", %{chats: chats}) do
    %{chats: chats}
  end
end
