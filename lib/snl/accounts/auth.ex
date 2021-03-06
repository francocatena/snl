defmodule Snl.Accounts.Auth do
  alias Snl.Repo
  alias Snl.Accounts.User

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  @doc false
  def authenticate_by_email_and_password(email, password) do
    user = Repo.get_by(User, email: email)

    cond do
      user && checkpw(password, user.password_hash) ->
        {:ok, user}
      true ->
        dummy_checkpw()
        {:error, :unauthorized}
    end
  end
end
