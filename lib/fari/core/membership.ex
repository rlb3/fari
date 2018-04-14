defmodule Fari.Core.Membership do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "memberships" do
    field :admin, :boolean, default: false
    field :user_id, :binary_id
    field :group_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(membership, attrs) do
    membership
    |> cast(attrs, [:admin])
    |> validate_required([:admin])
  end
end
