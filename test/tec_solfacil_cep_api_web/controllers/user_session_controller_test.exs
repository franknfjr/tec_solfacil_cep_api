defmodule TecSolfacilCepApiWeb.UserSessionControllerTest do
  use TecSolfacilCepApiWeb.ConnCase

  import TecSolfacilCepApi.AccountsFixtures

  describe "log_in/2" do
    test "creates a user session and provides a token", %{conn: conn} do
      user_fixture()

      conn = post(conn, Routes.user_session_path(conn, :log_in, %{session: valid_user()}))

      assert %{"data" => %{"token" => _token}} = json_response(conn, 200)
      assert %{"status" => "ok"} = json_response(conn, 200)
    end

    test "return unauthorized error for an invalid login", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.user_session_path(conn, :log_in, %{
            session: invalid_user()
          })
        )

      assert conn.status == 401
    end
  end
end
