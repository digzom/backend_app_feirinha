defmodule BackendAppFeirinha.Repo do
  use Ecto.Repo,
    otp_app: :backend_app_feirinha,
    adapter: Ecto.Adapters.Postgres

  if System.get_env("MIX_ENV") == :prod do
    def init(_, config) do
      config =
        config
        |> Keyword.put(:username, System.get_env("PGUSER"))
        |> Keyword.put(:password, System.get_env("PGPASSWORD"))
        |> Keyword.put(:database, System.get_env("PGDATABASE"))
        |> Keyword.put(:hostname, System.get_env("PGHOST"))
        |> Keyword.put(:port, System.get_env("PGPORT") |> String.to_integer())

      {:ok, config}
    end
  end
end
