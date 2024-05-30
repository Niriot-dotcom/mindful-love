defmodule MindfulloveWeb.Step2 do
  use MindfulloveWeb, :live_component

  alias MindfulloveWeb.Stepper

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex w-full justify-center">
      <div class="w-4/6 flex space-x-5">
        <%!-- calendar --%>
        <div phx-update="ignore" id="calendar-wrapper" class="h-full">
          <div
            id="appointment-calendar"
            phx-hook="Calendar"
            class=""
          >
          </div>
          <%!-- data-unavailable-dates={Jason.encode!(@bookings)} --%>
        </div>

        <%!-- hours --%>
        <div class="grid grid-cols-3 gap-3 h-fit">
          <button
            phx-click="select-hour"
            phx-value-hour={hour}
            class={
              if hour == @selected_time, do:
                "whitespace-nowrap border-2 border-blue bg-blue text-white font-bold rounded-xl px-3 py-1 text-center",
              else:
                "h-fit w-28 whitespace-nowrap border-2 border-turquoise hover:border-blue hover:bg-blue text-turquoise hover:text-white font-bold rounded-xl px-3 py-1 text-center transition-all ease-linear duration-200"}
            :for={hour <- [8, 9, 10, 11, 12, 13, 16, 17, 18, 19]}
          >
            <%!-- <%= if hour > 12, do: "#{hour - 12}:00 PM", else: "#{hour}:00 AM" %> --%>
            <%= if hour > 12, do: "#{hour}:00", else: "#{hour}:00" %>
          </button>
        </div>
      </div>
    </div>
    """
  end
end
