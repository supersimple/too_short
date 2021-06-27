defmodule TooShortWeb.LinkLive do
  @moduledoc """
  LiveView for screen that creates new short urls.
  """

  use TooShortWeb, :live_view

  alias TooShort.{Link, Links}

  @recent_links 10

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       url: "",
       url_valid?: nil,
       short_url: "",
       recent: Links.get_recent(@recent_links)
     )}
  end

  @impl true
  def handle_event("shorten_url", %{"url" => url}, socket) do
    case shorten(url) do
      {:ok, %Link{short_code: short_code} = new_link} ->
        short_url = Routes.link_url(TooShortWeb.Endpoint, :show, short_code)
        recent = build_recent_list(new_link, socket.assigns.recent)

        {:noreply,
         assign(socket, %{short_url: short_url, url: "", url_valid?: nil, recent: recent})}

      _ ->
        {:noreply, put_flash(socket, :error, "There was an error creating your short link")}
    end
  end

  @impl true
  def handle_event("validate_url", %{"url" => url}, socket) do
    if Link.url_valid?(url) do
      {:noreply, assign(socket, :url_valid?, true)}
    else
      {:noreply, assign(socket, :url_valid?, false)}
    end
  end

  defp build_recent_list(head, list) do
    [head]
    |> Kernel.++(list)
    |> Enum.take(@recent_links)
  end

  defp validation_class(true), do: "border-green-700"
  defp validation_class(false), do: "border-red-700"
  defp validation_class(_), do: "border-gray-700"

  defp shorten(url) do
    short_code = Link.generate_short_code()
    Links.create(%{url: url, short_code: short_code})
  end
end
