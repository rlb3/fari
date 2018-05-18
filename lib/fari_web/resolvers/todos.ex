defmodule FariWeb.Resolvers.Todos do
  import Ecto.Query

  def create(_obj, args, %{context: %{current_user: user}}) do
    user
    |> Ecto.build_assoc(:todos)
    |> Fari.Core.Todo.changeset(args)
    |> Fari.Repo.insert()
  end

  def complete(_obj, %{id: id}, %{context: %{current_user: user}}) do
    from(t in Fari.Core.Todo, where: t.user_id == ^user.id and t.id == ^id)
    |> Fari.Core.Todo.changeset(%{complete: true})
    |> Fari.Repo.update()
    |> notify_mark
  end

  defp notify_mark({:ok, todo}) do
    Absinthe.Subscription.publish(FariWeb.Endpoint, todo, marked_todo: "*")
    {:ok, todo}
  end
end
