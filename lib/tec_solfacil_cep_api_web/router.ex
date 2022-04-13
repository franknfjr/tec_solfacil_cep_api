defmodule TecSolfacilCepApiWeb.Router do
  use TecSolfacilCepApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug TecSolfacilCepApiWeb.Extensions.Pipeline.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api/v1", TecSolfacilCepApiWeb do
    pipe_through [:api, :auth]

    post "/register", UserSessionController, :sign_up
    post "/login", UserSessionController, :log_in
  end

  scope "/api/v1", TecSolfacilCepApiWeb do
    pipe_through [:api, :auth, :ensure_auth]

    get "/addresses", LocaleController, :index
    get "/addresses/:cep", LocaleController, :show
    post "/addresses", LocaleController, :create
  end
end
