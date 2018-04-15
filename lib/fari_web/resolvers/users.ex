defmodule FariWeb.Resolvers.Users do
  alias Fari.Repo
  alias Fari.Core.User

  def register(_obj, args, _ctx) do
    %User{}
    |> User.registration_changeset(args)
    |> Repo.insert
  end

  def list_users(_obj, _args, _ctx) do
    users = User |> Repo.all
    {:ok, users}
  end
end
