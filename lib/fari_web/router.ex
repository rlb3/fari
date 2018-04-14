defmodule FariWeb.Router do
  use FariWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: FariWeb.Schema
  end
end
