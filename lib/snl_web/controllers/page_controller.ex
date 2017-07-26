defmodule SnlWeb.PageController do
  use SnlWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
