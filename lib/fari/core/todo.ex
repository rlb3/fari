defmodule Fari.Core.Todo do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "todos" do
    field :complete, :boolean, default: false
    field :due_at, :utc_datetime
    field :priority, :boolean, default: false
    field :title, :string
    has_many :tasks, Fari.Core.Task
    belongs_to :user, Fari.Core.User

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :due_at, :priority, :complete])
    |> validate_required([:title, :due_at])
  end
end
