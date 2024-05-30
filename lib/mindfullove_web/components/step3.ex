defmodule MindfulloveWeb.Step3 do
  use MindfulloveWeb, :live_component

  alias MindfulloveWeb.Stepper

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col">
      ⚠️ Not implemented yet
    </div>
    """
  end
end
