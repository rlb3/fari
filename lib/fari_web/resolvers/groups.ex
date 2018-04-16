defmodule FariWeb.Resolvers.Groups do
  alias Fari.Repo
  alias Fari.Core.{Group, Membership}

  def create(_obj, args, %{context: %{current_user: user}}) do
    with {:ok, group} <- %Group{} |> Group.changeset(args) |> Repo.insert(),
         {:ok, _membership} <-
           %Membership{}
           |> Membership.changeset(%{admin: true, user_id: user.id, group_id: group.id})
           |> Repo.insert() do
      {:ok, group}
    else
      {:error, %{errors: [name: {message, _}]}} ->
        {:error, "Name #{message}"}

      {:error, message} ->
        {:error, message}
    end
  end

  def create(_obj, _args, _ctx) do
    {:error, "Unauthenticated"}
  end
end
