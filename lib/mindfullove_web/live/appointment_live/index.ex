defmodule MindfulloveWeb.AppointmentLive.Index do
  use MindfulloveWeb, :live_view

  alias Mindfullove.Appointments
  alias Mindfullove.Appointments.Appointment
  alias Timex, as: T

  on_mount({MindfulloveWeb.UserAuth, :mount_current_user})

  @impl true
  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_user.id

    active_appointments =
      Enum.filter(Appointments.list_appointments_by_user_id(user_id), fn appointment ->
        appointment.status == :ACTIVE
      end)

    {:ok, stream(socket, :appointments, active_appointments)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Appointment")
    |> assign(:appointment, Appointments.get_appointment!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Appointment")
    |> assign(:appointment, %Appointment{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Appointments")
    |> assign(:appointment, nil)
  end

  @impl true
  def handle_info({MindfulloveWeb.AppointmentLive.FormComponent, {:saved, appointment}}, socket) do
    {:noreply, stream_insert(socket, :appointments, appointment)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    appointment = Appointments.get_appointment!(id)
    {:ok, _} = Appointments.delete_appointment(appointment)

    {:noreply, stream_delete(socket, :appointments, appointment)}
  end
end
