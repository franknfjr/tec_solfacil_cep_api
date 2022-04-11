defmodule TecSolfacilCepApiWeb.Router do
  use TecSolfacilCepApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TecSolfacilCepApiWeb do
    pipe_through :api
  end
end
