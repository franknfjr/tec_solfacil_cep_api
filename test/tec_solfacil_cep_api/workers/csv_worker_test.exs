defmodule TecSolfacilCepApi.Workers.CSVWorkerTest do
  use TecSolfacilCepApi.DataCase
  use Oban.Testing, repo: TecSolfacilCepApi.Repo

  import TecSolfacilCepApi.LocalitiesFixtures

  alias TecSolfacilCepApi.Workers.CSVWorker

  describe "perform/1" do
    test "create job" do
      locale_fixture()

      email = "email@example.com"

      assert {:ok, csv} = perform_job(CSVWorker, %{email: email})
      assert csv == {:ok, %{}}
    end
  end
end
