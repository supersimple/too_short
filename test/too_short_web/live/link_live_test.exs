defmodule TooShortWeb.LinkLiveTest do
  use TooShortWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Too $hort URL"
    assert render(page_live) =~ "Too $hort URL"
  end

  describe "Creating a link" do
    test "giving a valid url", %{conn: conn} do
      {:ok, view, html} = live(conn, "/")
      assert html =~ "Shorten"
      assert view |> element("form") |> render_submit(%{"url" => "https://valid.url"})
      html = view |> render()
      assert html =~ ~r/http:\/\/localhost:4002\/.{6}/
    end

    test "Giving an invalid url", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      assert view |> element("form") |> render_submit(%{"url" => ""})
      html = view |> render()
      assert html =~ "There was an error"
    end

    test "While url value is invalid, show a red border", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")
      assert view |> element("form") |> render_change(%{"url" => "h"})
      _html = view |> render()
      assert view |> element("form.border-red-700") |> has_element?()
    end
  end
end
