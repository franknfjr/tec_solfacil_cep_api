defmodule TecSolfacilCepApi.Workers.CSVWorker do
  @moduledoc false
  use Oban.Worker, queue: :file_csv
  alias TecSolfacilCepApi.EmailSender
  alias TecSolfacilCepApi.Entities.Localities.Locale
  alias TecSolfacilCepApi.Repo

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"email" => email}}) do
    csv = build_csv()

    file = EmailSender.send_csv_to_email(csv, email)

    {:ok, file}
  end

  defp build_csv do
    Locale
    |> Repo.all()

    # implementing
  end
end
