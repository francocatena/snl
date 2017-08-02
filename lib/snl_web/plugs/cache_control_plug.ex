defmodule SnlWeb.CacheControlPlug do
  import Plug.Conn

  def put_cache_control_headers(%{assigns: %{current_user: user}} = conn, _opts)
  when is_map(user) do
    conn
    |> put_resp_header("cache-control", "no-cache, no-store, max-age=0, must-revalidate")
    |> put_resp_header("pragma",        "no-cache")
    |> put_resp_header("expires",       "Fri, 01 Jan 1990 00:00:00 GMT")
  end

  def put_cache_control_headers(conn, _opts), do: conn
end
