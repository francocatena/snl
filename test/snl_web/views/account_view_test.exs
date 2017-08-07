defmodule SnlWeb.AccountViewTest do
  use SnlWeb.ConnCase, async: true

  alias SnlWeb.AccountView
  alias Snl.Accounts
  alias Snl.Accounts.Account

  import Phoenix.View

  test "renders index.html", %{conn: conn} do
    accounts = [%Account{id: "1", name: "Google", db_prefix: "google"},
                %Account{id: "2", name: "Netflix", db_prefix: "netflix"}]
    content  = render_to_string(AccountView, "index.html",
                                conn: conn, accounts: accounts)

    for account <- accounts do
      assert String.contains?(content, account.name)
    end
  end

  test "renders new.html", %{conn: conn} do
    changeset = Accounts.change_account(%Account{})
    content   = render_to_string(AccountView, "new.html",
                                 conn: conn, changeset: changeset)

    assert String.contains?(content, "New account")
  end

  test "renders edit.html", %{conn: conn} do
    account   = %Account{id: "1", name: "Google", db_prefix: "google"}
    changeset = Accounts.change_account(account)
    content   = render_to_string(AccountView, "edit.html",
                                 conn: conn, account: account, changeset: changeset)

    assert String.contains?(content, account.name)
  end

  test "renders show.html", %{conn: conn} do
    account = %Account{id: "1", name: "Google", db_prefix: "google"}
    content = render_to_string(AccountView, "show.html",
                                 conn: conn, account: account)

    assert String.contains?(content, account.name)
  end
end
