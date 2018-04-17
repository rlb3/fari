defmodule FariWeb.Schema.TodoTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  object :user do
    field(:id, :id, description: "User ID")
    field(:email, :string, description: "Email")
    field(:first_name, :string, description: "First Name")
    field(:last_name, :string, description: "Last Name")

    field :full_name, :string, description: "Full name" do
      resolve(fn user, _, _ ->
        {:ok, "#{user.first_name} #{user.last_name}"}
      end)
    end

    field(
      :groups,
      list_of(:group),
      description: "User Groups",
      resolve: dataloader(Fari.Core.User, :groups)
    )
  end

  object :session do
    field(:token, :string, description: "JWT Token")
  end

  object :todo do
    field(:id, :id, description: "Todo id")
    field(:title, :string, description: "Todo Title")
    field(:priority, :boolean, description: "Priority?")
    field(:due_at, :date, description: "Due date")
  end

  scalar :date do
    parse(fn input ->
      case Timex.parse!(input.value, "{YYYY}-{0M}-{D}") |> DateTime.from_naive("Etc/UTC") do
        {:ok, date} -> {:ok, date}
        _ -> :error
      end
    end)

    serialize(fn date -> Date.to_iso8601(date) end)
  end
end
