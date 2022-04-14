defmodule TecSolfacilCepApi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TecSolfacilCepApi.Accounts` context.
  """

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "email@example.com",
        password: "password"
      })
      |> TecSolfacilCepApi.Accounts.create_user()

    user
  end
end
