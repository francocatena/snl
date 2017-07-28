defmodule SnlWeb.LayoutView do
  use SnlWeb, :view

  def locale do
    Gettext.get_locale(SnlWeb.Gettext)
  end

  def render_flash(conn) do
    case get_flash_message(conn) do
      {type, message} ->
        render("_flash.html", conn: conn, type: type, message: message)
      nil ->
        ""
    end
  end

  def flash_class(type) do
    if type == "info" do
      "is-info"
    else
      "is-danger"
    end
  end

  defp get_flash_message(conn) do
    conn
    |> Phoenix.Controller.get_flash
    |> Enum.at(0)
  end
end
