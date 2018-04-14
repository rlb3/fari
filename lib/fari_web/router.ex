defmodule FariWeb.Router do
  use FariWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FariWeb do
    pipe_through :api
  end
end
