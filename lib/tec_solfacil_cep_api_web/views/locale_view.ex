defmodule TecSolfacilCepApiWeb.LocaleView do
  use TecSolfacilCepApiWeb, :view
  alias TecSolfacilCepApiWeb.LocaleView

  def render("show.json", %{locale: locale}) do
    %{data: render_one(locale, LocaleView, "locale.json")}
  end

  def render("locale.json", %{locale: locale}) do
    %{
      cep: locale.cep,
      logradouro: locale.logradouro,
      complemento: locale.complemento,
      bairro: locale.bairro,
      localidade: locale.localidade,
      uf: locale.uf,
      ibge: locale.ibge,
      ddd: locale.ddd,
      siafi: locale.siafi
    }
  end

  def render("csv.json", _params) do
    %{detail: "Accepted", status: 202}
  end
end
