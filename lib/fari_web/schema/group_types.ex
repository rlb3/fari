defmodule FariWeb.Schema.GroupTypes do
  use Absinthe.Schema.Notation
  import Ecto.Query, only: [from: 2]

  object :group do
    field(:id, :id, description: "Group ID")
    field(:name, :string, description: "Group name")
  end
end
