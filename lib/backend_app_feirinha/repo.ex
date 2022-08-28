defmodule BackendAppFeirinha.Repo do
  use Ecto.Repo,
    otp_app: :backend_app_feirinha,
    adapter: Ecto.Adapters.Postgres
end
