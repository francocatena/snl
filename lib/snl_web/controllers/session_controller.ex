defmodule SnlWeb.SessionController do
  use SnlWeb, :controller

  def new(%{assigns: %{current_user: nil}} = conn, _params) do
    render(conn, "new.html")
  end

  def new(%{assigns: %{current_user: _}} = conn, _params) do
    redirect(conn, to: user_path(conn, :index))
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Snl.Accounts.authenticate_by_email_and_password(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext("Welcome!"))
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: user_path(conn, :index))
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, gettext("Invalid email/password combination"))
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> clear_session()
    |> put_flash(:info, gettext("See you soon!"))
    |> redirect(to: root_path(conn, :index))
  end
end
