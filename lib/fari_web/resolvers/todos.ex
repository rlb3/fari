defmodule FariWeb.Resolvers.Todos do
  import Ecto.Query

  def create(_obj, args, %{context: %{current_user: user}}) do
    Ecto.build_assoc(user, :todos)
    |> Fari.Core.Todo.changeset(args)
    |> Fari.Repo.insert()
  end

  def complete(_obj, %{id: id}, %{context: %{current_user: user}}) do
    from(t in Fari.Core.Todo, where: t.user_id == ^user.id and t.id == ^id)
    |> Fari.Core.Todo.changeset(%{complete: true})
    |> Fari.Repo.update

  end
end
