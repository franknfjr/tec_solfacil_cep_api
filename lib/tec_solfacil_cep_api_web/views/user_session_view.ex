defmodule TecSolfacilCepApiWeb.UserSessionView do
  use TecSolfacilCepApiWeb, :view

  def render("sign_up.json", %{user: user}) do
    %{
      status: :ok,
      message: user.email
    }
  end

  def render("log_in.json", %{user: user, jwt: jwt}) do
    %{
      status: :ok,
      data: %{
        token: jwt,
        email: user.email
      },
      message:
        "You are successfully logged in! Add this token to authorization header to make authorized requests."
    }
  end
end
