defmodule TecSolfacilCepApi.Entities.Localities.Locale do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(cep logradouro complemento bairro localidade uf ibge ddd siafi)a
  @required_fields ~w(cep logradouro bairro localidade uf ibge ddd siafi)a

  schema "addresses" do
    field :cep, :string
    field :logradouro, :string
    field :complemento, :string
    field :bairro, :string
    field :localidade, :string
    field :uf, :string
    field :ibge, :string
    field :ddd, :string
    field :siafi, :string

    timestamps()
  end

  @doc false
  def changeset(locale, attrs) do
    locale
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:cep)
  end
end
