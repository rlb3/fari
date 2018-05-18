defmodule FariWeb.Router do
  use FariWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:resource)
  end

  scope "/" do
    pipe_through(:api)

    forward(
      "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: FariWeb.Schema,
      socket: FariWeb.UserSocket
    )
  end

  defp resource(conn, _opt) do
    with ["Bearer " <> token] <- get_req_header(conn, "authentication"),
         {:ok, user, _claims} <- Fari.Guardian.resource_from_token(token) do
      conn
      |> Plug.Conn.put_private(:absinthe, %{context: %{current_user: user}})
    else
      {:error, :token_expired} ->
        conn

      error ->
        IO.inspect(error)
        conn
    end
  end
end
