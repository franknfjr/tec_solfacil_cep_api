defmodule TecSolfacilCepApi.Services.EmailSenderTest do
  @moduledoc false
  use TecSolfacilCepApi.DataCase
  use Oban.Testing, repo: TecSolfacilCepApi.Repo

  import Swoosh.TestAssertions
  import TecSolfacilCepApi.LocalitiesFixtures

  alias TecSolfacilCepApi.Workers.CSVWorker

  describe "send_csv_to_email/2" do
    test "send an email with started process with oban" do
      locale_fixture()

      email = "email@example.com"

      perform_job(CSVWorker, %{email: email})

      assert {:email, email} = assert_email_sent()
      refute email.attachments == []
    end
  end
end
