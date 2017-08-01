defmodule SnlWeb.CacheControlPlugTest do
  use SnlWeb.ConnCase, async: true

  alias SnlWeb.CacheControlPlug

  setup %{conn: conn} = config do
    do_setup conn, config[:login_as]
  end

  describe "cache control headers" do
    @tag login_as: "test@user.com"
    test "put cache control headers correctly when current user", %{conn: conn} do
      conn = CacheControlPlug.put_cache_control_headers(conn, [])

      assert get_resp_header(conn, "cache-control") == ["no-cache, no-store, max-age=0, must-revalidate"]
      assert get_resp_header(conn, "pragma")        == ["no-cache"]
      assert get_resp_header(conn, "expires")       == ["Fri, 01 Jan 1990 00:00:00 GMT"]
    end

    test "do not put cache control headers when no current user", %{conn: conn} do
      conn = CacheControlPlug.put_cache_control_headers(conn, [])

      refute get_resp_header(conn, "cache-control") == ["no-cache, no-store, max-age=0, must-revalidate"]
    end

    @tag login_as: "test@user.com"
    test "put cache control headers through browser pipe when current user", %{conn: conn} do
      conn =
        conn
        |> bypass_through(SnlWeb.Router, :browser)
        |> get("/")

      assert get_resp_header(conn, "cache-control") == ["no-cache, no-store, max-age=0, must-revalidate"]
      assert get_resp_header(conn, "pragma")        == ["no-cache"]
      assert get_resp_header(conn, "expires")       == ["Fri, 01 Jan 1990 00:00:00 GMT"]
    end
  end

  defp do_setup(_, nil), do: :ok
  defp do_setup(conn, _) do
    conn = assign(conn, :current_user, %Snl.Accounts.User{})

    {:ok, conn: conn}
  end
end
