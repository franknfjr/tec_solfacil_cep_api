defmodule TecSolfacilCepApi.Client.ViaCep do
  @base_url "https://viacep.com.br/ws/"
  @tec_solfacil_cep_api :tec_solfacil_cep_api

  @data ~w(cep logradouro complemento bairro localidade uf ibge ddd siafi)

  def get_address(cep) do
    :get
    |> Finch.build(@base_url <> "#{cep}" <> "/json/")
    |> Finch.request(@tec_solfacil_cep_api)
    |> handle_response
  end

  defp handle_response(request) do
    case request do
      {:ok, %{body: "{\n  \"erro\": true\n}", status: 200}} ->
        {:error, :not_found}

      {:ok, %{body: body, status: 200}} ->
        {:ok, decoded_body} = Jason.decode(body)

        result =
          decoded_body
          |> Map.take(@data)

        {:ok, result}

      _error ->
        {:error, :invalid_cep}
    end
  end
end
