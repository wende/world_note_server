defmodule WorldNote.ChatsController do
  use WorldNote.Web, :controller

  alias WorldNote.Chats

  plug :scrub_params, "chats" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    chats = Repo.all(Chats)
    render(conn, "index.json", chats: chats)
  end

  def create(conn, %{"chats" => chats_params}) do
    changeset = Chats.changeset(%Chats{}, chats_params)

    if changeset.valid? do
      chats = Repo.insert(changeset)
      render(conn, "show.json", chats: chats)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(WorldNote.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chats = Repo.get(Chats, id)
    render conn, "show.json", chats: chats
  end

  def update(conn, %{"id" => id, "chats" => chats_params}) do
    chats = Repo.get(Chats, id)
    changeset = Chats.changeset(chats, chats_params)

    if changeset.valid? do
      chats = Repo.update(changeset)
      render(conn, "show.json", chats: chats)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(WorldNote.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chats = Repo.get(Chats, id)

    chats = Repo.delete(chats)
    render(conn, "show.json", chats: chats)
  end
end
