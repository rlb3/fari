defmodule FariWeb.Router do
  use FariWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
    plug(:resource)
  end

  scope "/" do
    pipe_through(:api)

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: FariWeb.Schema)
  end

  defp resource(conn, _opt) do
    case  get_req_header(conn, "authentication") do
      ["Bearer " <> token] ->
        case token do
          "" -> conn
          token ->
            case Fari.Guardian.resource_from_token(token) do
              {:ok, user, _claims} ->
                Plug.Conn.put_private(conn, :absinthe, %{context: %{current_user: user}})
            end
        end

      _ -> conn
    end
  end
end
