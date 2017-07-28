defmodule SnlWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use SnlWeb, :controller
      use SnlWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: SnlWeb
      import Plug.Conn
      import SnlWeb.Router.Helpers
      import SnlWeb.Gettext
      import SnlWeb.SessionPlug, only: [authenticate: 2]
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/snl_web/templates",
                        namespace: SnlWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import SnlWeb.Router.Helpers
      import SnlWeb.ErrorHelpers
      import SnlWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import SnlWeb.SessionPlug, only: [fetch_current_user: 2]
      import SnlWeb.CacheControlPlug, only: [put_cache_control_headers: 2]
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import SnlWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
