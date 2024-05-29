defmodule MindfulloveWeb.AppointmentLive.Show do
  use MindfulloveWeb, :live_view

  alias Mindfullove.Appointments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:appointment, Appointments.get_appointment!(id))}
  end

  defp page_title(:show), do: "Show Appointment"
  defp page_title(:edit), do: "Edit Appointment"
end
