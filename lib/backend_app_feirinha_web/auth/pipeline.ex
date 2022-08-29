defmodule BackendAppFeirinhaWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :backend_app_feirinha

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
