defmodule BackendAppFeirinhaWeb.UserView do
  use BackendAppFeirinhaWeb, :view
  alias BackendAppFeirinhaWeb.UserView

  def render("index.json", %{users: users, token: token}) do
    render_many(%{users: users, token: token}, UserView, "user.json")
  end

  def render("show.json", %{user: user, token: token}) do
    render_one(%{user: user, token: token}, UserView, "user.json")
  end

  def render("show_updated_user.json", %{user: user}) do
    %{
      user: %{
        name: user.name,
        id: user.id,
        password_hash: user.password_hash,
        email: user.email
      }
    }
  end

  def render("user.json", %{user: %{user: user, token: token}}) do
    %{
      token: token,
      user: %{
        name: user.name,
        id: user.id,
        password_hash: user.password_hash,
        email: user.email
      }
    }
  end

  def render("sign_in.json", %{token: token, user: user}) do
    %{
      token: token,
      user: %{
        name: user.name,
        id: user.id,
        email: user.email
      }
    }
  end
end
