defmodule Fari.Core.Membership do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "memberships" do
    field(:admin, :boolean, default: false)
    belongs_to(:user, Fari.Core.User)
    belongs_to(:group_id, Fari.Core.Group)

    timestamps()
  end

  @doc false
  def changeset(membership, attrs) do
    membership
    |> cast(attrs, [:admin, :user_id, :group_id])
    |> validate_required([:admin, :user_id, :group_id])
  end
end
