defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug Ueberauth #plug ?

  alias Discuss.User

  def callback(%{assigns: %{ueberauth_auth: auth}} = _conn, _params) do
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)
    merge_user(changeset)

  end

  defp merge_user(changeset) do #insert_or_update_user

    case Repo.get_by(User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end

  end

end
