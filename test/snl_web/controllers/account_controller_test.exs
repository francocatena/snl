defmodule SnlWeb.AccountControllerTest do
  use SnlWeb.ConnCase
  use Snl.Support.LoginHelper

  import Snl.Support.FixtureHelper

  @create_attrs  %{db_prefix: "db_prefix", name: "some name"}
  @update_attrs  %{db_prefix: "updated_db_prefix", name: "some updated name"}
  @invalid_attrs %{db_prefix: "db prefix", name: nil}

  describe "unauthorized access" do
    test "requires account authentication on all actions", %{conn: conn} do
      Enum.each([
        get(conn,    account_path(conn, :index)),
        get(conn,    account_path(conn, :new)),
        post(conn,   account_path(conn, :create, %{})),
        get(conn,    account_path(conn, :show, "123")),
        get(conn,    account_path(conn, :edit, "123")),
        put(conn,    account_path(conn, :update, "123", %{})),
        delete(conn, account_path(conn, :delete, "123"))
      ], fn conn ->
        assert html_response(conn, 302)
        assert conn.halted
      end)
    end
  end

  describe "index" do
    @tag login_as: "test@user.com"
    test "lists all accounts", %{conn: conn} do
      conn = get conn, account_path(conn, :index)

      assert html_response(conn, 200) =~ "Accounts"
    end
  end

  describe "new account" do
    @tag login_as: "test@user.com"
    test "renders form", %{conn: conn} do
      conn = get conn, account_path(conn, :new)

      assert html_response(conn, 200) =~ "New account"
    end
  end

  describe "create account" do
    @tag login_as: "test@user.com"
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, account_path(conn, :create), account: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == account_path(conn, :show, id)
    end

    @tag login_as: "test@user.com"
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, account_path(conn, :create), account: @invalid_attrs

      assert html_response(conn, 200) =~ "New account"
    end
  end

  describe "edit account" do
    setup [:create_account]

    @tag login_as: "test@user.com"
    test "renders form for editing chosen account", %{conn: conn, account: account} do
      conn = get conn, account_path(conn, :edit, account)

      assert html_response(conn, 200) =~ account.name
    end
  end

  describe "update account" do
    setup [:create_account]

    @tag login_as: "test@user.com"
    test "redirects when data is valid", %{conn: conn, account: account} do
      conn = put conn, account_path(conn, :update, account), account: @update_attrs

      assert redirected_to(conn) == account_path(conn, :show, account)
    end

    @tag login_as: "test@user.com"
    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put conn, account_path(conn, :update, account), account: @invalid_attrs

      assert html_response(conn, 200)
    end
  end

  describe "delete account" do
    setup [:create_account]

    @tag login_as: "test@user.com"
    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete conn, account_path(conn, :delete, account)

      assert redirected_to(conn) == account_path(conn, :index)
    end
  end

  defp create_account(_) do
    account = fixture(:account, @create_attrs)

    {:ok, account: account}
  end
end
