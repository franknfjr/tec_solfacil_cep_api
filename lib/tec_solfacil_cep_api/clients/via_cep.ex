defmodule TecSolfacilCepApi.Clients.ViaCep do
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
      {:ok, %{body: "{\n  \"erro\": \"true\"\n}", status: 200}} ->
        {:error, :not_found}

      {:ok, %{body: body, status: 200}} ->
        {:ok, decoded_body} = Jason.decode(body)

        result =
          decoded_body
          |> Map.take(@data)
          |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
          |> format_cep()

        {:ok, result}

      _error ->
        {:error, :bad_request}
    end
  end

  defp format_cep(result) do
    formated_cep =
      result.cep
      |> String.replace("-", "")

    %{result | cep: formated_cep}
  end
end
