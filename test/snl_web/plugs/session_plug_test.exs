defmodule SnlWeb.SessionPlugTest do
  use SnlWeb.ConnCase, async: true

  alias SnlWeb.SessionPlug

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(SnlWeb.Router, :browser)
      |> get("/")

    {:ok, %{conn: conn}}
  end

  describe "fetch current user" do
    test "fetch current user from session", %{conn: conn} do
      user = fixture(:user)

      refute conn.assigns.current_user

      login_conn =
        conn
        |> put_session(:user_id, user.id)
        |> SessionPlug.fetch_current_user([])
        |> send_resp(:ok, "")

      next_conn = get(login_conn, "/")

      assert get_session(next_conn, :user_id) == user.id
    end

    test "fetch continues when current_user exists", %{conn: conn} do
      refute conn.assigns.current_user

      conn =
        conn
        |> assign(:current_user, %Snl.Accounts.User{})
        |> SessionPlug.fetch_current_user([])

      assert conn.assigns.current_user
    end

    test "fetch no user if no user_id on session and not set on assigns", %{conn: conn} do
      conn = SessionPlug.fetch_current_user(conn, [])

      refute conn.assigns.current_user
    end
  end

  describe "authentication" do
    test "authenticate halts when no current_user exists", %{conn: conn} do
      refute conn.halted

      conn = SessionPlug.authenticate(conn, [])

      assert conn.halted
    end

    test "authenticate continues when the current_user exists", %{conn: conn} do
      conn =
        conn
        |> assign(:current_user, %Snl.Accounts.User{})
        |> SessionPlug.authenticate([])

      refute conn.halted
    end
  end

  defp fixture(:user) do
    {:ok, user} = Snl.Accounts.create_user(%{
      name:     "some name",
      lastname: "some lastname",
      email:    "some@email.com",
      password: "123456"
    })

    user
  end
end
