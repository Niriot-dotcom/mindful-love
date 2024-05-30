defmodule MindfulloveWeb.Step1 do
  use MindfulloveWeb, :live_component

  alias MindfulloveWeb.Stepper

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col">
      <div class="grid grid-cols-3 gap-3">
        <.psychologist_card psychologist={p} :for={p <- @psychologists} />
      </div>
    </div>
    """
  end
end
