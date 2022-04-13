defmodule TecSolfacilCepApiWeb.Router do
  use TecSolfacilCepApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", TecSolfacilCepApiWeb do
    pipe_through :api

    get "/addresses", LocaleController, :index
    get "/addresses/:cep", LocaleController, :show
    post "/addresses", LocaleController, :create
  end
end
