defmodule FariWeb.Resolvers.Users do
  alias Fari.Repo
  alias Fari.Core.User

  def register(_obj, args, _ctx) do
    %User{}
    |> User.registration_changeset(args)
    |> Repo.insert
  end

  def login(_obj, args, _ctx) do
    user = Repo.get_by(User, email: args.email)
    case Comeonin.Argon2.check_pass(user, args.password) do
      {:ok, user} ->
        {:ok, user}
      {:error, _message} ->
        Comeonin.Argon2.dummy_checkpw
        {:error, "Bad Username or password"}
    end
  end

  def list_users(_obj, _args, _ctx) do
    users = User |> Repo.all
    {:ok, users}
  end
end
