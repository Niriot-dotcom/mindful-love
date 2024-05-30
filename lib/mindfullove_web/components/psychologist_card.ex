defmodule MindfulloveWeb.PsychologistCard do
  use Phoenix.Component
  import MindfulloveWeb.CoreComponents

  def psychologist_card(assigns) do
    ~H"""
    <div class="flex flex-col p-10 bg-blue rounded-xl justify-between text-white cursor-pointer">
      <div class="text-center" phx-click={show_modal("psychologist-info")}>
        <img class="w-full h-32 mb-5 object-contain" src="https://jorgecolonconsulting.com/wp-content/uploads/elixir.png" />

        <%!-- modality --%>
        <div class="flex space-x-2 justify-center text-black">
          <p class="text-xs p-2 bg-light lowercase font-bold w-fit rounded-xl">online</p>
          <p class="text-xs p-2 bg-light lowercase font-bold w-fit rounded-xl">on-site</p>
        </div>

        <h1 class="text-xl font-semibold"><%= assigns.psychologist.occupation %>. <%= assigns.psychologist.first_name %> <%= assigns.psychologist.last_name %></h1>
        <p class="text-lg">psychologist.pronouns</p>
      </div>
    </div>

    <.modal id="psychologist-info">
      <div class="flex h-full">
        <%!-- profile --%>
        <div class="px-3 flex flex-col min-h-full w-4/12 rounded-xl justify-center text-center space-y-3">
          <img class="w-full h-32 object-contain" src="https://jorgecolonconsulting.com/wp-content/uploads/elixir.png" />

          <div>
            <h1 class="text-xl font-semibold"><%= assigns.psychologist.occupation %>. <%= assigns.psychologist.first_name %> <%= assigns.psychologist.last_name %></h1>
            <p class="text-lg">since 2018</p>
          </div>

          <%!-- modality --%>
          <div class="flex space-x-2 justify-center">
            <p class="text-xs py-1 px-2 bg-light lowercase font-bold w-fit rounded-xl">online</p>
            <p class="text-xs py-1 px-2 bg-light lowercase font-bold w-fit rounded-xl">on-site</p>
          </div>
        </div>

        <%!-- description --%>
        <div class="h-full w-8/12 p-5 bg-gray rounded-xl flex flex-col space-y-3 overflow-hidden">
          <%!-- address --%>
          <div class="flex items-center">
            <.icon name="hero-map-pin" class="mr-1 h-5 w-5" />
            <p class="text-lg"><%= assigns.psychologist.address %></p>
          </div>
          <div class="flex items-center">
            <.icon name="hero-link" class="mr-1 h-5 w-5" />
            <p class="text-lg">Link</p>
          </div>

          <%!-- specialties --%>
          <div class="flex flex-col space-y-1">
            <div class="flex items-center">
              <.icon name="hero-light-bulb" class="mr-1 h-5 w-5" />
              <p class="text-lg">Focus on</p>
            </div>

            <div class="flex space-x-1 flex-wrap gap-y-1 justify-start">
              <p class="text-xs py-1 px-2 border border-slate-400 lowercase font-bold w-fit rounded-xl">sports</p>
              <p class="text-xs py-1 px-2 border border-slate-400 lowercase font-bold w-fit rounded-xl">military</p>
              <p class="text-xs py-1 px-2 border border-slate-400 lowercase font-bold w-fit rounded-xl">child</p>
            </div>
          </div>

          <%!-- schedule an appointment --%>
          <div class="w-full text-right">
            <button class="bg-turquoise hover:bg-blue text-white font-bold py-3 rounded-xl px-5 text-center">
              Make an appointment
            </button>
          </div>
        </div>
      </div>
    </.modal>
    """
  end
end
