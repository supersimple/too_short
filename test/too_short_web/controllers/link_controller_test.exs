defmodule TooShortWeb.LinkControllerTest do
  use TooShortWeb.ConnCase

  describe "show" do
    test "returns 404 when the short code doesnt exist", %{conn: conn} do
      conn = get(conn, Routes.link_path(conn, :show, "jklmno"))
      response = html_response(conn, 404)
      assert response =~ "404"
    end

    test "returns 301 and redirects when short code is valid", %{conn: conn} do
      link = insert(:link)
      conn = get(conn, Routes.link_path(conn, :show, link.short_code))
      assert redirected_to(conn, 301) == link.url
    end
  end
end
