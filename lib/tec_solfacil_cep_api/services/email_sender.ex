defmodule TecSolfacilCepApi.Services.EmailSender do
  @moduledoc false
  import Swoosh.Email
  alias TecSolfacilCepApi.Mailer

  def send_csv_to_email(file, email) do
    new()
    |> to({"noreply", "noreply@tecsolfacil.com"})
    |> from({email, email})
    |> subject("All csv's!")
    |> html_body("<h1>Hello #{email}!")
    |> text_body("Hello #{email}!")
    |> attachment(
      Swoosh.Attachment.new({:data, file},
        filename: "tecsolfacil_addresses.csv",
        content_type: "text/csv"
      )
    )
    |> Mailer.deliver()
  end
end
