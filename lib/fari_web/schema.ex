defmodule FariWeb.Schema do
  use Absinthe.Schema
  import_types(FariWeb.Schema.TodoTypes)

  query do
    field :users, list_of(:user), description: "Users" do
      resolve(&FariWeb.Resolvers.Users.list_users/3)
    end
  end

  mutation do
    field :register, non_null(:user) do
      arg(:first_name, :string, description: "First name")
      arg(:last_name, :string, description: "Last name")
      arg(:email, non_null(:string), description: "The users email")
      arg(:password, non_null(:string), description: "Thes users password")

      resolve(&FariWeb.Resolvers.Users.register/3)
    end

    field :login, non_null(:session) do
      arg(:email, :string, description: "User's email")
      arg(:password, :string, description: "Password")

      resolve(&FariWeb.Resolvers.Users.login/3)
    end
  end
end
