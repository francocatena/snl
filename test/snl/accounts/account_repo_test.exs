defmodule Snl.Accounts.AccountRepoTest do
  use Snl.DataCase

  describe "account" do
    alias Snl.Accounts.Account

    @valid_attrs %{name: "some name", db_prefix: "db_prefix"}

    test "converts unique constraint on db prefix to error" do
      account   = fixture(:account, @valid_attrs)
      attrs     = Map.put(@valid_attrs, :db_prefix, account.db_prefix)
      changeset = Account.changeset(%Account{}, attrs)

      assert {:error, changeset} = Repo.insert(changeset)
      assert "has already been taken" in errors_on(changeset).db_prefix
    end
  end
end
