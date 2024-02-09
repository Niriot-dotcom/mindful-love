defmodule MindfulloveWeb.DashboardController do
  use MindfulloveWeb, :controller

  def index(conn, _params) do
    render(conn, :index, layout: false)
  end

  def handle_event("create_new_appointment", %{"parametro" => valor}, socket) do
    IO.puts("Se ha hecho clic en el botón con el valor: #{valor}")
    {:noreply, socket}
  end
  def handle_event("close_user_session", _value, socket) do
    # {:noreply, update(socket, :temperature, &(&1 + 1))}
    IO.puts "handle event logout"
    {:noreply, socket}
  end
end
