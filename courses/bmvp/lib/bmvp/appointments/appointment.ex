defmodule Bmvp.Appointments.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "appointments" do
    field :status, :string
    field :date, :naive_datetime
    field :user_id, :binary_id
    field :psychologist_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:user_id, :date, :status])
    |> validate_required([:date, :status])
  end
end
