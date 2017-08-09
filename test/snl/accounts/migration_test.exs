defmodule Snl.Accounts.MigrationTest do
  use Snl.DataCase

  alias Snl.Accounts.Migration

  describe "accounts" do
    test "account_prefixes/0 returns all account prefixes" do
      account = fixture(:account)

      assert Migration.account_prefixes() == ["t_#{account.db_prefix}"]
    end
  end
end
