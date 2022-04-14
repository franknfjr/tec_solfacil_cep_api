defmodule TecSolfacilCepApi.Localities do
  @moduledoc """
  The Localities context.
  """

  import Ecto.Query, warn: false
  alias TecSolfacilCepApi.Repo

  alias TecSolfacilCepApi.Client.ViaCep
  alias TecSolfacilCepApi.Entities.Localities.Locale
  alias TecSolfacilCepApi.Workers.CSVWorker

  @doc """
  Get a locale by cep

  ## Examples

      iex> get_locale_by_cep("05408-003")
      {:ok, locale}

      iex> get_locale_by_cep("00000-000")
      {:error, :not_found}

  """
  def get_locale_by_cep(cep) when is_binary(cep) do
    with nil <- Repo.get_by(Locale, cep: cep |> String.replace("-", "")),
         {:ok, result} <- ViaCep.get_address(cep |> String.replace("-", "")) do
      create_locale_address(result)
    else
      {:error, reason} ->
        {:error, reason}

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

  def build_csv_addresses(email) do
    %{email: email}
    |> CSVWorker.new()
    |> Oban.insert()
  end
end
