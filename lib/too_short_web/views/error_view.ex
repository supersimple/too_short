defmodule TooShortWeb.ErrorView do
  use TooShortWeb, :view

  def render("not_found.html", _assigns) do
    render("404.html", %{})
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
