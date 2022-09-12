defmodule BackendAppFeirinha.FeatureCase do
  # allow me to use this module in every test
  use ExUnit.CaseTemplate

  # everything in the using body will be used in our test module
  using do
    quote do
      # imports several functions from Wallaby.Browser and aliases
      # Wallaby.Query functions to use in our feature tests
      use Wallaby.DSL
      alias BackendAppFeirinhaWeb.Router.Helpers, as: Routes

      # imports all macros and functions of the modules, but
      # unamespaced
      import BackendAppFeirinha.Factory
      # using path helpers
      @endpoint BackendAppFeirinhaWeb.Endpoint
    end
  end

  # every thing in the setup body runs before every test
  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(BackendAppFeirinha.Repo)

    unless tags[:async] do
      # the repo is shared only if the current test is not asynchronous
      Ecto.Adapters.SQL.Sandbox.mode(BackendAppFeirinha.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(BackendAppFeirinha.Repo, self())
    # just like phoenix did with controller tests (with conn), we do with
    # session in Wallaby to make integration tests. Creating a session
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
