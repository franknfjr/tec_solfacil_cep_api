defmodule TecSolfacilCepApiWeb.LocaleController do
  use TecSolfacilCepApiWeb, :controller

  alias TecSolfacilCepApi.Localities

  def send_csv(conn, _params) do
    %{email: email} = Guardian.Plug.current_resource(conn)
    Localities.build_csv_addresses(email)

    conn
    |> put_status(202)
    |> render("csv.json")
  end

  def show(conn, %{"cep" => cep}) do
    {:ok, locale} = Localities.get_locale_by_cep(cep)
    render(conn, "show.json", locale: locale)
  end
end
