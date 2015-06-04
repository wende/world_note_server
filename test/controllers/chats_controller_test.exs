defmodule WorldNote.ChatsControllerTest do
  use WorldNote.ConnCase

  alias WorldNote.Chats
  @valid_attrs %{content: "some content", fbid: 42, latitude: "120.5", longitude: "120.5"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, chats_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    chats = Repo.insert %Chats{}
    conn = get conn, chats_path(conn, :show, chats)
    assert json_response(conn, 200)["data"] == %{
      "id" => chats.id
    }
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, chats_path(conn, :create), chats: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Chats, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, chats_path(conn, :create), chats: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    chats = Repo.insert %Chats{}
    conn = put conn, chats_path(conn, :update, chats), chats: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Chats, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    chats = Repo.insert %Chats{}
    conn = put conn, chats_path(conn, :update, chats), chats: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    chats = Repo.insert %Chats{}
    conn = delete conn, chats_path(conn, :delete, chats)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Chats, chats.id)
  end
end
