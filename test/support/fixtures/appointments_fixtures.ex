defmodule Mindfullove.AppointmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mindfullove.Appointments` context.
  """

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(attrs \\ %{}) do
    {:ok, appointment} =
      attrs
      |> Enum.into(%{
        date: ~N[2024-02-21 17:34:00],
        status: :CANCELLED
      })
      |> Mindfullove.Appointments.create_appointment()

    appointment
  end
end
