defmodule SnlWeb.SessionPlug do
  import Phoenix.Controller
  import Plug.Conn
  import SnlWeb.Gettext

  alias Snl.Accounts
  alias SnlWeb.Router.Helpers

  def fetch_current_user(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user    = user_id && Accounts.get_user!(user_id)

    assign(conn, :current_user, user)
  end

  def authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, gettext("You must be logged in."))
      |> redirect(to: Helpers.session_path(conn, :new))
      |> halt()
    end
  end
end
