defmodule TecSolfacilCepApi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TecSolfacilCepApi.Accounts` context.
  """

  def valid_user,
    do: %{
      email: "email@example.com",
      password: "password"
    }

  def invalid_user,
    do: %{
      email: "foo@bar.com",
      password: "fooo"
    }

  def valid_user_password, do: "password"

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(valid_user())
      |> TecSolfacilCepApi.Accounts.create_user()

    user
  end
end
