defmodule FariWeb.Schema.TodoTypes do
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id, description: "User ID"
    field :email, :string, description: "Email"
    field :first_name, :string, description: "First Name"
    field :last_name, :string, description: "Last Name"
    field :full_name, :string, description: "Full name" do
      resolve fn user, _, _ ->
        {:ok, "#{user.first_name} #{user.last_name}"}
      end
    end
  end
end
