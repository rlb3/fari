defmodule Fari.Authentication do
  @behaviour Absinthe.Middleware
  @moduledoc false

  def call(resolution, config) do
    case resolution.context do
      %{current_user: _} ->
        resolution

      %{token_expired: true} ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "token expired"})

      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unauthenticated"})
    end
  end
end
