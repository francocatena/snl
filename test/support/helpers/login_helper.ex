defmodule Snl.Support.LoginHelper do
  use ExUnit.CaseTemplate
  use Phoenix.ConnTest

  alias Snl.Accounts.User

  using do
    quote do
      import Snl.Support.LoginHelper

      setup %{conn: conn} = config do
        do_setup conn, config[:login_as]
      end
    end
  end

  def do_setup(_, nil), do: :ok
  def do_setup(conn, email) do
    user = %User{email: email, lastname: "some lastname", name: "some name"}
    conn = assign(conn, :current_user, user)

    {:ok, conn: conn, user: user}
  end
end
