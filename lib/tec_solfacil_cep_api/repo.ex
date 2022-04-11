defmodule TecSolfacilCepApi.Repo do
  use Ecto.Repo,
    otp_app: :tec_solfacil_cep_api,
    adapter: Ecto.Adapters.Postgres
end
