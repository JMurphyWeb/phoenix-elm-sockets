defmodule Sockets.RoomChannel do
  use Sockets.Web, :channel

  def join("room:lobby", payload, socket) do
    IO.puts "Successful join ----------"
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join(_room, _params, _socket) do
    {:error, %{reason: "only the lobby is accessible"}}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  # def handle_in("new:msg", payload, socket) do
  #   IO.inspect payload["body"]
  #   {:reply, {:ok, payload}, socket}
  # end
  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("new:msg", payload, socket) do
    IO.inspect socket
    IO.inspect payload
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
