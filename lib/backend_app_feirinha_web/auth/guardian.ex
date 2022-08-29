defmodule BackendAppFeirinhaWeb.Auth.Guardian do
  use Guardian, otp_app: :backend_app_feirinha
  alias BackendAppFeirinha.{Repo, Users.User}

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    resource = BackendAppFeirinha.Users.get_user!(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  def authenticate(%{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :unauthorized}
      user -> validate_password(user, password)
    end
  end

  def validate_password(%User{password_hash: password_hash} = user, password) do
    case Argon2.verify_pass(password, password_hash) do
      true -> create_token(user)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, token}
  end
end
