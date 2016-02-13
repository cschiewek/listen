defmodule Listen.BroadcastChannel do
  use Phoenix.Channel

  def join("broadcast", _message, socket) do
    {:ok, socket}
  end

  def handle_out("play", payload, socket) do
    push socket, "play", payload
    {:noreply, socket}
  end
end
