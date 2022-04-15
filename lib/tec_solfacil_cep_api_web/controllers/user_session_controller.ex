defmodule TecSolfacilCepApiWeb.UserSessionController do
  use TecSolfacilCepApiWeb, :controller

  alias TecSolfacilCepApi.Accounts
  alias TecSolfacilCepApi.Entities.Accounts.User
  alias TecSolfacilCepApi.Guardian
  alias TecSolfacilCepApi.Repo

  action_fallback TecSolfacilCepApiWeb.FallbackController

  def sign_up(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("sign_up.json", user: user)

      {:error, _changeset} ->
        conn
        |> put_status(:forbidden)
        |> put_view(TecSolfacilCepApiWeb.ErrorView)
        |> render(:"403")
    end
  end

  def log_in(conn, %{"session" => %{"email" => email, "password" => password}}) do
    if user = Accounts.get_user_by_email_and_password(email, password) do
      {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)

      conn
      |> render("log_in.json", user: user, jwt: jwt)
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(TecSolfacilCepApiWeb.ErrorView)
      |> render(:"401")
    end
  end
end
