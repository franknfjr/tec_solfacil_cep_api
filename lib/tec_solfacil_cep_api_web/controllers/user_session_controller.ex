defmodule TecSolfacilCepApiWeb.UserSessionController do
  use TecSolfacilCepApiWeb, :controller

  alias TecSolfacilCepApi.Accounts
  alias TecSolfacilCepApi.Entities.Accounts.User
  alias TecSolfacilCepApi.Guardian
  alias TecSolfacilCepApi.Repo

  def sign_up(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("sign_up.json", user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TecSolfacilCepApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def log_in(conn, %{"session" => %{"email" => email, "password" => password}}) do
    {:ok, user} = Accounts.get_user_by_email_and_password(email, password)

    case user do
      user ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)

        conn
        |> render("log_in.json", user: user, jwt: jwt)
    end
  end
end
