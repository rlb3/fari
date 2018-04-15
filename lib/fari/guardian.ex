defmodule Fari.Guardian do
  use Guardian, otp_app: :fari
  alias Fari.Repo
  alias Fari.Core.User

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    user = Repo.get(User, id)
    {:ok,  user}
  end
  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
