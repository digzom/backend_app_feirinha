defmodule BackendAppFeirinhaWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use BackendAppFeirinhaWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  @default_opts [
    store: :cookie,
    key: "secretkey",
    encryption_salt: "encrypted cookie salt",
    signing_salt: "signing salt"
  ]

  @signing_opts Plug.Session.init(Keyword.put(@default_opts, :encrypt, false))

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import BackendAppFeirinhaWeb.ConnCase

      alias BackendAppFeirinhaWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint BackendAppFeirinhaWeb.Endpoint
    end
  end

  setup tags do
    # :ok = Ecto.Adapters.SQL.Sandbox.checkout(BackendAppFeirinha.Repo)
    BackendAppFeirinha.DataCase.setup_sandbox(tags)
    conn = Phoenix.ConnTest.build_conn()

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(BackendAppFeirinha.Repo, {:shared, self()})
    end

    if tags[:authenticated] do
      {:ok, user} =
        BackendAppFeirinha.Users.create_user(%{
          name: "Dickson",
          password: "123456",
          email: "dickson@email.com"
        })

      conn =
        conn
        |> Plug.Session.call(@signing_opts)
        |> Plug.Conn.fetch_session()
        |> Guardian.Plug.sign_in(BackendAppFeirinhaWeb.Auth.Guardian, user)

      {:ok, conn: conn, user: user}
    else
      {:ok, conn: conn, user: nil}
    end
  end
end
