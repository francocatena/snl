defmodule SnlWeb.LayoutView do
  use SnlWeb, :view

  def locale do
    Gettext.get_locale(SnlWeb.Gettext)
  end

  def show_flash_messages?(conn) do
    conn
    |> Phoenix.Controller.get_flash
    |> Enum.any?
  end
end
