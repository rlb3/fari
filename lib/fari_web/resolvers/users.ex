defmodule FariWeb.Resolvers.Users do
  alias Fari.Repo
  alias Fari.Core.User

  def me(_obj, _args, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def me(_obj, _args, _ctx) do
    {:error, "Unauthenticated"}
  end

  def register(_obj, args, _ctx) do
    with {:ok, user} <- %User{} |> User.registration_changeset(args) |> Repo.insert(),
         {:ok, token, _claims} <- Fari.Guardian.encode_and_sign(user) do
      {:ok, %{token: token}}
    else
      {:error, %{errors: [email: {message, _}]}} ->
        {:error, "That email #{message}"}
    end
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

  def list_users(_obj, _args, %{context: %{current_user: user}}) do
    user = user |> Repo.preload(:groups)
    users = Enum.map(user.groups, fn g -> g.id end)
    |> Enum.map(fn id -> Fari.Repo.get(Fari.Core.Group, id) end)
    |> Enum.map(fn group -> group |> Fari.Repo.preload(:users) end)
    |> Enum.map(fn g -> g.users end)
    |> List.flatten()

    {:ok, users}
  end
end
