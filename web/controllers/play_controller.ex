defmodule Listen.PlayController do
  use Listen.Web, :controller

  # TODO: validatate url
  def play(conn, %{"url" => url}), do: _play(conn, url, url)

  # TODO: validate file
  def play(conn, %{"file" => file}) do
    audio = file.path |> File.read! |> Base.encode64
    _play(conn, "data:#{file.content_type};base64," <> audio, file.filename)
  end

  defp _play(conn, source, name) do
    status = case Listen.Endpoint.broadcast!("broadcast", "play", %{src: source, name: name}) do
      :ok -> 200
      :error -> 422
    end

    conn
    |> put_status(status)
    |> text("")
  end
end
