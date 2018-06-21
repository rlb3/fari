defmodule Fari.Auth do
  def resource_from_token(%Plug.Conn{} = conn) do
    with ["Bearer " <> token] <- Plug.Conn.get_req_header(conn, "authorization"),
         {:ok, user, _claims} <- Fari.Guardian.resource_from_token(token) do
      {:ok, user}
    else
      error ->
        error
    end
  end

  def resource_from_token(bearer) when is_binary(bearer) do
    with "Bearer " <> token <- bearer,
         {:ok, user, _claims} <- Fari.Guardian.resource_from_token(token) do
      {:ok, user}
    else
      error ->
        error
    end
  end
end
