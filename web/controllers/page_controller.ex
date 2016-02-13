defmodule Listen.PageController do
  use Listen.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
