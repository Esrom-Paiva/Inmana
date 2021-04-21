defmodule Inmana.Supplies.Notification do
  alias Inmana.Mailer
  alias Inmana.Supplies.{ExpirationEmail, ShowByExpiration}

  def send do
    data = ShowByExpiration.call()

    Enum.each(data, fn {to_email, supplies} ->
      to_email
      |> ExpirationEmail.create(supplies)
      |> Mailer.deliver_later!()
    end)
  end
end
