defmodule TecSolfacilCepApi.EmailSender do
  @moduledoc false
  import Swoosh.Email
  alias TecSolfacilCepApi.Mailer

  def send_email(email) do
    new()
    |> to({"noreply", "noreply@tecsolfacil.com"})
    |> from({email, email})
    |> subject("All csv's!")
    |> html_body("<h1>Hello #{email}!")
    |> text_body("Hello #{email}!")
    |> Mailer.deliver()
  end
end
