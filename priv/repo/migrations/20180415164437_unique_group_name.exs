defmodule Fari.Repo.Migrations.UniqueGroupName do
  use Ecto.Migration

  def change do
    create unique_index(:groups, [:name])
  end
end
