defmodule Inmana.Supply do
  use Ecto.Schema
  import Ecto.Changeset

  alias Inmana.Restaurant

  @primary_key {:id, :binary_id, autogenerate: true}

  @foreign_key_type :binary_id

  @require_params [:description, :expiration_date, :responsible, :restaurant_id]

  @derive {Jason.Encoder, only: @require_params ++ [:id]}

  schema "supplies" do
    field :description, :string
    field :expiration_date, :date
    field :responsible, :string

    belongs_to :restaurant, Restaurant

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @require_params)
    |> validate_required(@require_params)
    |> validate_length(:description, min: 2)
    |> validate_length(:responsible, min: 2)
  end
end
