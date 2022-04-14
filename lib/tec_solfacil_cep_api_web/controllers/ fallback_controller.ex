defmodule TecSolfacilCepApiWeb.FallbackController do
  use TecSolfacilCepApiWeb, :controller

  @behaviour Guardian.Plug.ErrorHandler

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(TecSolfacilCepApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(TecsolfacilWeb.ErrorView)
    |> render(:"400")
  end

  def call(conn, {:error, :forbidden}) do
    conn
    |> put_status(:forbidden)
    |> put_view(TecSolfacilCepApiWeb.ErrorView)
    |> render(:"403")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(TecSolfacilCepApiWeb.ErrorView)
    |> render(:"404")
  end

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_status(:unauthorized)
    |> put_view(TecSolfacilCepApiWeb.ErrorView)
    |> render(:"401")
  end
end
