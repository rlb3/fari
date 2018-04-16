defmodule FariWeb.Resolvers.Groups do
  alias Fari.Repo
  alias Fari.Core.{Group, Membership}

  def create(_obj, args, %{context: %{current_user: user}}) do
    group =
      %Group{}
      |> Group.changeset(args)
      |> Repo.insert()

    case group do
      {:ok, group} ->
        %Membership{}
        |> Membership.changeset(%{admin: true, user_id: user.id, group_id: group.id})
        |> Repo.insert()

        {:ok, group}

      {:error, %{errors: [name: {message, _}]}} ->
        {:error, "Name #{message}"}
    end
  end

  def create(_obj, _args, _ctx) do
    {:error, "Unauthenticated"}
  end
end
