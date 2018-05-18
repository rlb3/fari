defmodule FariWeb.Schema do
  use Absinthe.Schema
  import_types(FariWeb.Schema.TodoTypes)
  import_types(FariWeb.Schema.GroupTypes)

  subscription do
    field :marked_todo, :todo do
      config fn _args, _info ->
        {:ok, topic: "*"}
      end

      resolve fn root, _, _ ->
        {:ok, root}
      end
    end
  end

  query do
    field :me, :user, description: "The current user" do
      resolve(&FariWeb.Resolvers.Users.me/3)
    end

    field :users, list_of(:user), description: "List users in my groups" do
      resolve(&FariWeb.Resolvers.Users.list_users/3)
    end
  end

  mutation do
    field :register, non_null(:session) do
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

    field :group_create, non_null(:group) do
      arg(:name, :string, description: "Group name")

      resolve(&FariWeb.Resolvers.Groups.create/3)
    end

    field :todo_create, non_null(:todo) do
      arg(:title, :string)
      arg(:complete, :boolean)
      arg(:priority, :boolean)
      arg(:due_at, :date)
      
      resolve(&FariWeb.Resolvers.Todos.create/3)
    end

    field :todo_complete, non_null(:todo) do
      arg :id, :id
      
      resolve &FariWeb.Resolvers.Todos.complete/3
    end
  end

  def dataloader() do
    Dataloader.new()
    |> Dataloader.add_source(Fari.Core.User, Fari.Core.data())
    |> Dataloader.add_source(Fari.Core.Todo, Fari.Core.data())
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end
end
