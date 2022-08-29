defmodule BackendAppFeirinhaWeb.Router do
  use BackendAppFeirinhaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug BackendAppFeirinhaWeb.Auth.Pipeline
  end

  scope "/api", BackendAppFeirinhaWeb do
    pipe_through :api

    post "/users", UserController, :create
    post "/users/signin", UserController, :sign_in
  end

  scope "/api", BackendAppFeirinhaWeb do
    pipe_through [:api, :auth]

    resources "/products", ProductController, except: [:new, :edit]
    resources "/users", UserController, only: [:show, :delete, :update]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BackendAppFeirinhaWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
