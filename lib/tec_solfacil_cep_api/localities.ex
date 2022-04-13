defmodule TecSolfacilCepApi.Localities do
  @moduledoc """
  The Localities context.
  """

  import Ecto.Query, warn: false
  alias TecSolfacilCepApi.Repo

  alias TecSolfacilCepApi.Entities.Localities.Locale

  @doc """
  Returns the list of adresses.

  ## Examples

      iex> list_adresses()
      [%Locale{}, ...]

  """
  def list_adresses do
    Repo.all(Locale)
  end

  @doc """
  Get a locale by cep

  ## Examples

      iex> get_locale_by_cep("05408-003")
      {:ok, locale}

      iex> get_locale_by_cep("00000-000")
      {:error, :not_found}

  """
  def get_locale_by_cep(cep) when is_binary(cep) do
    case Repo.get_by(Locale, cep: cep) do
      nil ->
        {:error, :not_found}

      locale ->
        {:ok, locale}
    end
  end

  @doc """
  Creates a locale address.

  ## Examples

      iex> create_locale_address(%{field: value})
      {:ok, %User{}}

      iex> create_locale_address(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_locale_address(attrs \\ %{}) do
    %Locale{}
    |> Locale.changeset(attrs)
    |> Repo.insert()
  end
end