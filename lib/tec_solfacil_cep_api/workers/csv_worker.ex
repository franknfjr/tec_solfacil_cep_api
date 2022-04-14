defmodule TecSolfacilCepApi.Workers.CSVWorker do
  @moduledoc false
  use Oban.Worker, queue: :file_csv
  alias TecSolfacilCepApi.Services.EmailSender
  alias TecSolfacilCepApi.Entities.Localities.Locale
  alias TecSolfacilCepApi.Repo

  @fields ~w(cep logradouro complemento bairro localidade uf ibge ddd siafi)a

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"email" => email}}) do
    csv = build_csv()

    file = EmailSender.send_csv_to_email(csv, email)

    {:ok, file}
  end

  defp build_csv do
    Locale
    |> Repo.all()
    |> Enum.map(fn record ->
      record
      |> Map.from_struct()
      |> Map.take([])
      |> Map.merge( Map.take(record, @fields) )
      |> Map.values()
    end)
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end
end
