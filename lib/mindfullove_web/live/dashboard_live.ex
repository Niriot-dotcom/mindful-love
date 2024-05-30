defmodule MindfulloveWeb.DashboardLive do
  use MindfulloveWeb, :live_view

  def mount(_params, _session, socket) do
    # socket =
    #   assign(socket,
    #     key: value
    #   )

    {:ok, socket}
  end

  # handlers
  def handle_event("create_new_appointment", %{"parametro" => valor}, socket) do
    # Imprimir en la consola del servidor
    IO.puts("Se ha hecho clic en el botón con el valor: #{valor}")

    # Devolver el socket sin ningún cambio
    {:noreply, socket}
  end

  def handle_event("close_user_session", _value, socket) do
    # {:noreply, update(socket, :temperature, &(&1 + 1))}
    IO.puts "handle event logout"
    {:noreply, socket}
  end
end
