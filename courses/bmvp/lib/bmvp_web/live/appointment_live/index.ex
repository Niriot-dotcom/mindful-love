defmodule BmvpWeb.AppointmentLive.Index do
  use BmvpWeb, :live_view

  alias Bmvp.Appointments
  alias Bmvp.Appointments.Appointment

  on_mount({BmvpWeb.AccountAuth, :mount_current_account})

  @impl true
  def mount(_params, _session, socket) do
    account_id = socket.assigns.current_account.id
    {:ok, stream(socket, :appointments, Appointments.list_appointments_by_account_id(account_id))}
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
  def handle_info({BmvpWeb.AppointmentLive.FormComponent, {:saved, appointment}}, socket) do
    {:noreply, stream_insert(socket, :appointments, appointment)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    appointment = Appointments.get_appointment!(id)
    {:ok, _} = Appointments.delete_appointment(appointment)

    {:noreply, stream_delete(socket, :appointments, appointment)}
  end
end
