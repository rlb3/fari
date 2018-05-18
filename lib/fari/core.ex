defmodule Fari.Core do
  alias Fari.Repo
  import Ecto.Query

  def data() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  # def query(Fari.Core.Todo, _) do
  #   from(t in Fari.Core.Todo, where: t.complete == ^false)
  # end

  def query(queryable, _) do
    queryable
  end
end
