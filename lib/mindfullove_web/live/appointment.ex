defmodule MindfulloveWeb.AppointmentLive do
  use MindfulloveWeb, :live_view

  alias Mindfullove.Psychologists
  alias MindfulloveWeb.Stepper
  alias MindfulloveWeb.Step1
  alias MindfulloveWeb.Step2
  alias MindfulloveWeb.Step3

  def mount(_params, _session, socket) do
    {:ok,
      assign(socket,
        psychologists: Psychologists.list_psychologists(),
        bookings: [],
        selected_date: nil,
        selected_time: nil,
        step_active: 1
      )
    }
  end

  def render(assigns) do
    ~H"""
    <div class="flex space-x-3 pt-9 px-20">
      <div class="h-full w-full p-10 bg-gray rounded-xl flex flex-col space-y-3 overflow-hidden">
        <.live_component module={Stepper} id="appointment-stepper" step_active={@step_active} />

        <%!-- action panel --%>
        <div class="flex flex-col">
          <%!-- step 1: select psychologist --%>
          <.live_component :if={@step_active == 1} module={Step1} id="appointment-step-1" psychologists={@psychologists} />

          <%!-- step 2: schedule an available time --%>
          <.live_component :if={@step_active == 2} module={Step2} id="appointment-step-2" selected_time={@selected_time} />

          <%!-- step 3: review and confirm  --%>
          <.live_component :if={@step_active == 3} module={Step3} id="appointment-step-3" psychologists={@psychologists} />
        </div>
      </div>
    </div>
    """
  end

  # handlers
  def handle_event("date-picked", date, socket) do
    {:noreply, assign(socket, selected_date: parse_date(date))}
  end

  def handle_event("book-selected-dates", _, socket) do
    %{selected_date: selected_date, bookings: bookings} = socket.assigns

    socket =
      socket
      |> assign(:bookings, [selected_date | bookings])
      |> assign(:selected_date, nil)
      |> assign(:selected_time, nil)
      |> push_event("add-unavailable-dates", selected_date)

    {:noreply, socket}
  end

  def handle_event("unavailable-dates", _, socket) do
    {:reply, %{dates: socket.assigns.bookings}, socket}
  end

  def handle_event("select-hour", %{"hour" => hour}, socket) do
    {:noreply, assign(socket, selected_time: String.to_integer(hour))}
  end

  def handle_event("next-step", params, socket) do
    if socket.assigns.step_active < 3 do
      socket =
        assign(socket,
          step_active: socket.assigns.step_active + 1
        )
      {:noreply, socket}
    else
      socket = push_navigate(socket, to: ~p"/dashboard")
      {:noreply, socket}
    end
  end

  def handle_event("previous-step", params, socket) do
    socket =
      assign(socket,
        step_active: socket.assigns.step_active - 1
      )
    {:noreply, socket}
  end

  def format_date(date) do
    Timex.format!(date, "%m/%d", :strftime)
  end

  def parse_date(date_string) do
    date_string
    |> Timex.parse!("{ISO:Extended}")
    |> Timex.Timezone.convert(:local)
    |> Timex.to_date()
  end
end
