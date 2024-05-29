defmodule Mindfullove.AppointmentsTest do
  use Mindfullove.DataCase

  alias Mindfullove.Appointments

  describe "appointments" do
    alias Mindfullove.Appointments.Appointment

    import Mindfullove.AppointmentsFixtures

    @invalid_attrs %{status: nil, date: nil}

    test "list_appointments/0 returns all appointments" do
      appointment = appointment_fixture()
      assert Appointments.list_appointments() == [appointment]
    end

    test "get_appointment!/1 returns the appointment with given id" do
      appointment = appointment_fixture()
      assert Appointments.get_appointment!(appointment.id) == appointment
    end

    test "create_appointment/1 with valid data creates a appointment" do
      valid_attrs = %{status: :CANCELLED, date: ~N[2024-02-21 17:34:00]}

      assert {:ok, %Appointment{} = appointment} = Appointments.create_appointment(valid_attrs)
      assert appointment.status == :CANCELLED
      assert appointment.date == ~N[2024-02-21 17:34:00]
    end

    test "create_appointment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Appointments.create_appointment(@invalid_attrs)
    end

    test "update_appointment/2 with valid data updates the appointment" do
      appointment = appointment_fixture()
      update_attrs = %{status: :ACTIVE, date: ~N[2024-02-22 17:34:00]}

      assert {:ok, %Appointment{} = appointment} = Appointments.update_appointment(appointment, update_attrs)
      assert appointment.status == :ACTIVE
      assert appointment.date == ~N[2024-02-22 17:34:00]
    end

    test "update_appointment/2 with invalid data returns error changeset" do
      appointment = appointment_fixture()
      assert {:error, %Ecto.Changeset{}} = Appointments.update_appointment(appointment, @invalid_attrs)
      assert appointment == Appointments.get_appointment!(appointment.id)
    end

    test "delete_appointment/1 deletes the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{}} = Appointments.delete_appointment(appointment)
      assert_raise Ecto.NoResultsError, fn -> Appointments.get_appointment!(appointment.id) end
    end

    test "change_appointment/1 returns a appointment changeset" do
      appointment = appointment_fixture()
      assert %Ecto.Changeset{} = Appointments.change_appointment(appointment)
    end
  end
end
