defmodule SnlWeb.RootController do
  use SnlWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: session_path(conn, :new))
  end
end
