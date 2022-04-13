defmodule TecSolfacilCepApiWeb.Extensions.Pipeline.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :tec_solfacil_cep_api,
    error_handler: TecSolfacilCepApiWeb.Extensions.Pipeline.ErrorHandler,
    module: TecSolfacilCepApi.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
