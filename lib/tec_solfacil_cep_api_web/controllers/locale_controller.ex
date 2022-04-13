defmodule TecSolfacilCepApiWeb.LocaleController do
  use TecSolfacilCepApiWeb, :controller

  alias TecSolfacilCepApi.Entities.Localities.Locale
  alias TecSolfacilCepApi.Localities

  def index(conn, _params) do
    adresses = Localities.list_adresses()
    render(conn, "index.json", adresses: adresses)
  end

  def create(conn, %{"locale" => locale_params}) do
    with {:ok, %Locale{} = locale} <- Localities.create_locale_address(locale_params) do
      conn
      |> put_status(:created)
      |> render("show.json", locale: locale)
    end
  end

  def show(conn, %{"cep" => cep}) do
    {:ok, locale} = Localities.get_locale_by_cep(cep)
    render(conn, "show.json", locale: locale)
  end
end
