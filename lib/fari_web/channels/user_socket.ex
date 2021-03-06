defmodule FariWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: FariWeb.Schema
  require Logger

  ## Channels
  # channel "room:*", FariWeb.RoomChannel

  ## Transports
  transport(:websocket, Phoenix.Transports.WebSocket)
  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(params, socket) do
    Logger.info("connect")

    case auth(params["authorization"]) do
      {:ok, user} ->
        {:ok, assign(socket, :user, user)}

      _ ->
        :error
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     FariWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil

  defp auth(token) do
    case Fari.Auth.resource_from_token(token) do
      {:ok, user} -> {:ok, user}
      _ -> :error
    end
  end
end
