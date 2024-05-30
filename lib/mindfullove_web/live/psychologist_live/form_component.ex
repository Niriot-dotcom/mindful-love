defmodule MindfulloveWeb.PsychologistLive.FormComponent do
  use MindfulloveWeb, :live_component

  alias Mindfullove.Psychologists

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage psychologist records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="psychologist-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:first_name]} type="text" label="First name" />
        <.input field={@form[:last_name]} type="text" label="Last name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:birthdate]} type="datetime-local" label="Birthdate" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:occupation]} type="text" label="Occupation" />
        <.input
          id="multiselect-specialties"
          phx-hook="MultiSelect"
          field={@form[:specialties]}
          type="select"
          multiple
          label="Specialties"
          options={[{"Child", "child"}, {"Sports", "sports"}, {"Gender", "gender"}, {"Educational", "educational"}, {"Industrial", "industrial"}, {"Military", "military"}, {"Forensic", "forensic"}]}
        />
        <%!-- <.input
          id="multiselect-specialties"
          field={@form[:specialties]}
          type="checkbox"
          options={[{"Child", "child"}, {"Sports", "sports"}, {"Gender", "gender"}, {"Educational", "educational"}, {"Industrial", "industrial"}, {"Military", "military"}, {"Forensic", "forensic"}]}
        /> --%>
        <%= for {text, k} <- [{"Child", "child"}, {"Sports", "sports"}, {"Gender", "gender"}, {"Educational", "educational"}, {"Industrial", "industrial"}, {"Military", "military"}, {"Forensic", "forensic"}] do %>
            <input
              type="checkbox"
              name="prices[]"
              value={text}
              id={k}
            />
            <label for={k}><%= text %></label>
          <% end %>
        <.input
          field={@form[:modalities]}
          type="select"
          label="Modalities"
          prompt="Choose a value"
          options={format_modalties()}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Psychologist</.button>
        </:actions>
      </.simple_form>

      <%!-- <script>
        function MultiSelect(el) {
          console.log("HERE MultiSelect")
          el.addEventListener('click', (event) => {
          console.log("HERE MultiSelect CLICKCKSKSK")
            event.preventDefault(); // Prevent default multi-select behavior
            const option = event.target.closest('option');
            if (option) {
              option.selected = !option.selected;
            }
          });
        }
      </script> --%>
    </div>
    """
  end

  @impl true
  def update(%{psychologist: psychologist} = assigns, socket) do
    changeset = Psychologists.change_psychologist(psychologist)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"psychologist" => psychologist_params}, socket) do
    changeset =
      socket.assigns.psychologist
      |> Psychologists.change_psychologist(psychologist_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"psychologist" => psychologist_params}, socket) do
    save_psychologist(socket, socket.assigns.action, psychologist_params)
  end

  defp save_psychologist(socket, :edit, psychologist_params) do
    case Psychologists.update_psychologist(socket.assigns.psychologist, psychologist_params) do
      {:ok, psychologist} ->
        notify_parent({:saved, psychologist})

        {:noreply,
         socket
         |> put_flash(:info, "Psychologist updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_psychologist(socket, :new, psychologist_params) do
    case Psychologists.create_psychologist(psychologist_params) do
      {:ok, psychologist} ->
        notify_parent({:saved, psychologist})

        {:noreply,
         socket
         |> put_flash(:info, "Psychologist created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp format_modalties() do
    modalties = Ecto.Enum.values(Mindfullove.Psychologists.Psychologist, :modalities)
    Enum.map(modalties, fn m -> m |> Atom.to_string() |> String.replace("_", " ") |> String.capitalize() end)
    |> Enum.with_index()
    |> Enum.map(fn {text, i} -> {text, Enum.at(modalties, i)} end)
  end
end
