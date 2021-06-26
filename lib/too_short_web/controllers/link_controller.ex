defmodule TooShortWeb.LinkController do
  use TooShortWeb, :controller
  alias TooShort.{Link, Links}

  def show(conn, %{"short_code" => short_code}) do
    case Links.get_by_short_code(short_code) do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(TooShortWeb.ErrorView)
        |> render(:not_found, conn.assigns)
        |> halt()

      %Link{url: url} ->
        conn
        |> put_status(301)
        |> redirect(external: url)
    end
  end
end
