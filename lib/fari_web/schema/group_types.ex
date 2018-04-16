defmodule FariWeb.Schema.GroupTypes do
  use Absinthe.Schema.Notation

  object :group do
    field(:id, :id, description: "Group ID")
    field(:name, :string, description: "Group name")
  end
end
