defmodule SnlWeb.UserView do
  use SnlWeb, :view

  def fullname(user) do
    Enum.join([user.name, user.lastname], " ")
  end
end
