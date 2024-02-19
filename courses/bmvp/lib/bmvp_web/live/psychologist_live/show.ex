defmodule BmvpWeb.PsychologistLive.Show do
  use BmvpWeb, :live_view

  alias Bmvp.Psychologists

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:psychologist, Psychologists.get_psychologist!(id))}
  end

  defp page_title(:show), do: "Show Psychologist"
  defp page_title(:edit), do: "Edit Psychologist"
end
