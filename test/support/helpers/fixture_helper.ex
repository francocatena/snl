defmodule Snl.Support.FixtureHelper do
  alias Snl.Accounts

  def fixture(type, attributes \\ %{})

  @user_attrs %{email: "some@email.com", lastname: "some lastname", name: "some name", password: "123456"}

  def fixture(:user, attributes) do
    account = fixture(:account)

    fixture(:user, attributes, account.id)
  end

  def fixture(:user, attributes, account_id) do
    {:ok, user} =
      attributes
      |> Enum.into(@user_attrs)
      |> Accounts.create_user(account_id)

    %{user | password: nil}
  end

  @account_attrs %{name: "fixture name", db_prefix: "fixture_prefix"}

  def fixture(:account, attributes) do
    {:ok, account} =
      attributes
      |> Enum.into(@account_attrs)
      |> Accounts.create_account()

    account
  end
end
