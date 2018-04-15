defmodule Fari.Core.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field(:complete, :boolean, default: false)
    field(:description, :string)
    field(:order, :integer)
    belongs_to(:todo, Fari.Core.Todo)

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:description, :complete, :order])
    |> validate_required([:description, :order])
  end
end
