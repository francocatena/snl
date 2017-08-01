defmodule SnlWeb.RootControllerTest do
  use SnlWeb.ConnCase

  describe "index" do
    test "redirect to new session", %{conn: conn} do
      conn = get(conn, root_path(conn, :index))

      assert redirected_to(conn) == session_path(conn, :new)
    end
  end
end
