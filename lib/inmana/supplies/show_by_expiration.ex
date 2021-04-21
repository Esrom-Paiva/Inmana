defmodule Inmana.Supplies.ShowByExpiration do
  import Ecto.Query

  alias Inmana.{Repo, Restaurant, Supply}

  def call do
    today = Date.utc_today()
    begin_week = Date.beginning_of_week(today)
    end_week = Date.end_of_week(today)

    query =
      from supply in Supply,
        where: supply.expiration_date >= ^begin_week and supply.expiration_date <= ^end_week,
        preload: [:restaurant]

    query
    |> Repo.all()
    |> Enum.group_by(fn %Supply{restaurant: %Restaurant{email: email}} -> email end)
  end
end
