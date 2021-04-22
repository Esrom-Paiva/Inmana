defmodule Inmana.Supplies.Notification do
  use Task
  alias Inmana.Mailer
  alias Inmana.Supplies.{ExpirationEmail, ShowByExpiration}

  def send do
    data = ShowByExpiration.call()

    data
    |> Task.async_stream(fn {to_email, supplies} -> send_email(to_email, supplies) end)
    |> Stream.run()
  end

  defp send_email(to_email, supplies) do
    to_email
    |> ExpirationEmail.create(supplies)
    |> Mailer.deliver_later!()
  end
end
