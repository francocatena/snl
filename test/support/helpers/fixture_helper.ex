defmodule Snl.Support.FixtureHelper do
  alias Snl.Accounts

  @user_attrs %{email: "some@email.com", lastname: "some lastname", name: "some name", password: "123456"}

  def fixture(:user, attributes \\ %{}) do
    {:ok, user} =
      @user_attrs
      |> Map.merge(attributes)
      |> Accounts.create_user()

    %{user | password: nil}
  end
end
