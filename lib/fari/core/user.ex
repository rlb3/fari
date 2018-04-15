defmodule Fari.Core.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    has_many(:todos, Fari.Core.Todo)
    many_to_many(:groups, Fari.Core.Group, join_through: Fari.Core.Membership)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email])
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> downcase_email()
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Argon2.hashpwsalt(pass))

      _ ->
        changeset
    end
  end

  defp downcase_email(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{email: email}} ->
        put_change(changeset, :email, String.downcase(email))

      _ ->
        changeset
    end
  end
end
