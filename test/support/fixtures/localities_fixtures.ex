defmodule TecSolfacilCepApi.LocalitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TecSolfacilCepApi.Localities` context.
  """
  def cep_valid, do: "67145037"
  def cep_invalid, do: "67000000"

  def address_data do
    %{
      "bairro" => "Maguari",
      "cep" => "67145037",
      "complemento" => "(Cj PAAR)",
      "ddd" => "91",
      "ibge" => "1500800",
      "localidade" => "Ananindeua",
      "logradouro" => "Quadra Cem",
      "siafi" => "0415",
      "uf" => "PA"
    }
  end

  def locale_fixture(attrs \\ %{}) do
    {:ok, locale} =
      attrs
      |> Enum.into(address_data())
      |> TecSolfacilCepApi.Localities.create_locale_address()

    locale
  end
end
