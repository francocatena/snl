defmodule SnlWeb.SessionControllerTest do
  use SnlWeb.ConnCase

  @valid_user   %{email: "some@email.com", lastname: "some lastname", name: "some name", password: "123456"}
  @invalid_user %{email: "wrong@email.com", password: "wrong"}

  describe "unauthorized access" do
    test "requires user on delete", %{conn: conn} do
      conn = delete(conn, session_path(conn, :delete))

      assert html_response(conn, 302)
      assert conn.halted
    end
  end

  describe "new session" do
    test "renders form", %{conn: conn} do
      conn = get conn, session_path(conn, :new)

      assert html_response(conn, 200) =~ ~r/Login/
    end

    test "redirects when current user", %{conn: conn} do
      conn =
        conn
        |> assign(:current_user, %Snl.Accounts.User{})
        |> get(session_path(conn, :new))

      assert redirected_to(conn) == user_path(conn, :index)
    end
  end

  describe "create session" do
    test "assigns current user when credentials are valid", %{conn: conn} do
      user = fixture(:user)
      conn = post conn, session_path(conn, :create), session: @valid_user

      assert user.id == get_session(conn, :user_id)
      assert redirected_to(conn) == user_path(conn, :index)
    end

    test "renders errors when credentials are invalid", %{conn: conn} do
      conn = post conn, session_path(conn, :create), session: @invalid_user

      refute get_session(conn, :user_id)
      assert html_response(conn, 200)
      assert get_flash(conn, :error) =~ ~r/Invalid/
    end
  end

  describe "delete" do
    test "clear session", %{conn: conn} do
      conn =
        conn
        |> assign(:current_user, %Snl.Accounts.User{})
        |> delete(session_path(conn, :delete))

      refute get_session(conn, :user_id)
      assert get_flash(conn, :info)
      assert redirected_to(conn) == root_path(conn, :index)
    end
  end

  defp fixture(:user) do
    {:ok, user} = Snl.Accounts.create_user(@valid_user)

    user
  end
end
