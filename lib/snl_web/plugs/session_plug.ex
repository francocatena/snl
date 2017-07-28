defmodule SnlWeb.SessionPlug do
  import Phoenix.Controller
  import Plug.Conn
  import SnlWeb.Gettext

  def fetch_current_user(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user    = user_id && Snl.Accounts.get_user!(user_id)

    assign(conn, :current_user, user)
  end

  def authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, gettext("You must be logged in."))
      |> redirect(to: SnlWeb.Router.Helpers.session_path(conn, :new))
      |> halt()
    end
  end
end
