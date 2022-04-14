defmodule TecSolfacilCepApi.LocalitiesTest do
  use TecSolfacilCepApi.DataCase
  use Oban.Testing, repo: TecSolfacilCepApi.Repo

  import TecSolfacilCepApi.LocalitiesFixtures

  alias TecSolfacilCepApi.Localities
  alias TecSolfacilCepApi.Workers.CSVWorker

  describe "get_locale_by_cep/1" do
    test "get a locale if cep exists" do
      locale = locale_fixture()
      {:ok, address} = Localities.get_locale_by_cep(locale.cep)
      assert address == locale
    end
  end

  describe "create_locale_address/1" do
    test "create the locale if data is ok" do
      Localities.create_locale_address(address_data())

      assert {:error, changeset} = Localities.create_locale_address(address_data())
      refute changeset.valid?
    end
  end

  describe "build_csv_addresses/1" do
    test "queues a workers csv " do
      locale_fixture()

      Localities.build_csv_addresses("email@example.com")

      assert_enqueued(worker: CSVWorker)
    end
  end
end
