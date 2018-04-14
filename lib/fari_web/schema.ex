defmodule FariWeb.Schema do
  use Absinthe.Schema
  import_types FariWeb.Schema.TodoTypes

  query do
    field :users, list_of(:user), description: "Users" do
      resolve &FariWeb.Resolvers.Users.list_users/3
    end
  end
end
