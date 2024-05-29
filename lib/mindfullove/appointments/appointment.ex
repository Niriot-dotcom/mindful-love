defmodule Mindfullove.Appointments.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field(:status, Ecto.Enum, values: [:CANCELLED, :ACTIVE])
    field(:date, :naive_datetime)
    field(:user_id, :id)
    field(:psychologist_id, :id)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:user_id, :date, :status])
    |> validate_required([:date, :status])
  end
end
