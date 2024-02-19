defmodule Bmvp.AppointmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bmvp.Appointments` context.
  """

  @doc """
  Generate a appointment.
  """
  def appointment_fixture(attrs \\ %{}) do
    {:ok, appointment} =
      attrs
      |> Enum.into(%{
        date: ~N[2024-02-18 19:50:00],
        status: "some status"
      })
      |> Bmvp.Appointments.create_appointment()

    appointment
  end
end
