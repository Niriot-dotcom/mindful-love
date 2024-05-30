defmodule MindfulloveWeb.Stepper do
  use MindfulloveWeb, :live_component

  @steps [
    %{"index" => 1, "title" => "Psychologist", "description" => "Select the person who will be selected" },
    %{"index" => 2, "title" => "Schedule", "description" => "What date and time works best for you?" },
    %{"index" => 3, "title" => "Review and confirm", "description" => "All right?" },
  ]

  def mount(socket) do
    IO.inspect(socket, label: "socket")
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <%!-- line with steps --%>
      <ul class="relative flex flex-col md:flex-row gap-2 justify-between">
        <li :for={step <- get_steps()} class="md:shrink md:basis-0 flex-1 group flex gap-x-2 md:block">
          <div class="min-w-7 min-h-7 flex flex-col items-center md:w-full md:inline-flex md:flex-wrap md:flex-row text-sm align-middle">
            <%= if assigns.step_active == step["index"] do %>
              <span class="bg-blue text-md p-3 flex justify-center items-center flex-shrink-0 bg-gray-100 font-medium text-white rounded-full dark:bg-neutral-700 dark:text-white">
                <%= step["index"] %>
              </span>
            <% else %>
              <span class="border-2 border-blue p-3 flex justify-center items-center flex-shrink-0 bg-gray-100 font-medium text-blue rounded-full dark:bg-neutral-700 dark:text-white">
                <%= step["index"] %>
              </span>
            <% end %>
            <div class="mt-2 w-px h-full md:mt-0 md:ms-2 md:w-full md:h-px md:flex-1 bg-gray-200 group-last:hidden dark:bg-neutral-700"></div>
          </div>
          <div class="grow md:grow-0 md:mt-3 pb-5">
            <span class="block text-md font-medium text-blue dark:text-white">
              <%= step["title"] %>
            </span>
            <p class="text-sm text-gray-500 dark:text-neutral-500">
              <%= step["description"] %>
            </p>
          </div>
        </li>
      </ul>

      <%!-- buttons --%>
      <div class="flex h-12 mb-3">
        <div class="">
          <.link navigate={"/dashboard"}>
            <button class="h-full w-32 border-2 border-turquoise hover:border-blue hover:bg-blue text-turquoise hover:text-white font-bold rounded-xl text-center transition-all ease-linear duration-200">
              Cancel
            </button>
          </.link>
        </div>

        <div class="w-full text-right">
          <button :if={assigns.step_active >= 2} phx-click="previous-step" class="h-full w-12 border-2 border-turquoise hover:border-blue hover:bg-blue text-turquoise hover:text-white font-bold rounded-xl text-center transition-all ease-linear duration-200">
            <.icon name="hero-arrow-left" class="" />
          </button>

          <%!-- TODO: disable when :if={@selected_dates} --%>
          <button phx-click="next-step" class="h-full w-32 bg-turquoise hover:bg-blue text-white font-bold rounded-xl text-center transition-all ease-linear duration-200">
            <%= if assigns.step_active == 3 do %>
              Confirm
            <% else %>
              Next <.icon name="hero-arrow-right" class="ml-3" />
            <% end %>
          </button>
        </div>
      </div>
    </div>
    """
  end

  # helper functions
  defp get_steps() do
    @steps
  end
end
