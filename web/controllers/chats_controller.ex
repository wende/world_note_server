defmodule WorldNote.ChatsController do
  use WorldNote.Web, :controller
  import Ecto.Query
  alias WorldNote.Chats

  plug :allow_origin
  plug :scrub_params, "chats" when action in [:create, :update]
  plug :action

  defp allow_origin(conn, _opts) do
    headers = get_req_header(conn, "access-control-request-headers") |> Enum.join(", ")

    conn
    |> put_resp_header("access-control-allow-origin", "*")
    |> put_resp_header("access-control-allow-headers", headers)
    |> put_resp_header("access-control-allow-methods", "get, post, put, options")
    |> put_resp_header("access-control-max-age", "3600")
  end

  def parse(string) do
    {a, ""} = Float.parse(string)
    a
  end

  def options(conn, _) do
    conn
  |> put_status(202)
  |> text "Ok"
  end

  def index(conn, %{"lat" => lat, "lng" => lng}) do
    # +-0.1 bounds of both
    latH = parse(lat) + 0.1
    latL = parse(lat) - 0.1
    lngH = parse(lng) + 0.1
    lngL = parse(lng) - 0.1

    query = from w in Chats,
            where: w.latitude   < ^latH and w.latitude  > ^latL
              and  w.longitude  < ^lngH and w.longitude > ^lngL,
            select: w
    chats = Repo.all(query)
    render(conn, "index.json", chats: chats)
  end

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
