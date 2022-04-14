defmodule TecSolfacilCepApiWeb.LocaleSessionControllerTest do
  use TecSolfacilCepApiWeb.ConnCase

  import TecSolfacilCepApi.AccountsFixtures
  import TecSolfacilCepApi.LocalitiesFixtures

  alias TecSolfacilCepApi.Guardian

  describe "show/2" do
    test "show a cep if exists", %{conn: conn} do
      user = user_fixture()
      {:ok, token, _claims} = Guardian.encode_and_sign(user, %{typ: "access"})

      result =
        conn
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(Routes.locale_path(conn, :show, cep_valid()))
        |> json_response(200)

      assert result == %{"data" => address_data()}
    end
  end

  test "if not exist a cep return some error", %{conn: conn} do
    user = user_fixture()
    {:ok, token, _claims} = Guardian.encode_and_sign(user, %{typ: "access"})

    result =
      conn
      |> put_req_header("authorization", "Bearer " <> token)
      |> get(Routes.locale_path(conn, :show, cep_invalid()))
      |> json_response(404)

    assert result == %{"errors" => %{"detail" => "Not Found"}}
  end
end
