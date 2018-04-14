defmodule Fari.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :text
      add :complete, :boolean, default: false, null: false
      add :order, :integer
      add :todo_id, references(:todos, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:tasks, [:todo_id])
  end
end
