defmodule FariWeb.Resolvers.Users do
  alias Fari.Repo
  alias Fari.Core.User


  def me(_obj, _args, ctx) do
    {:ok, ctx.context.current_user}
  end

  def register(_obj, args, _ctx) do
    %User{}
    |> User.registration_changeset(args)
    |> Repo.insert()
  end

  def login(_obj, args, _ctx) do
    user = Repo.get_by(User, email: args.email)

    with {:ok, user} <- Comeonin.Argon2.check_pass(user, args.password),
         {:ok, token, _} <- Fari.Guardian.encode_and_sign(user) do
      {:ok, %{token: token}}
    else
      {:error, "invalid password"} ->
        {:error, "Bad Username or password"}

      {:error, message} ->
        {:error, message}
    end
  end

  def list_users(_obj, _args, _ctx) do
    users = User |> Repo.all()
    {:ok, users}
  end
end
