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
          field={@form[:specialties]}
          type="select"
          multiple
          label="Specialties"
          options={[{"Option 1", "option1"}, {"Option 2", "option2"}]}
        />
        <.input
          field={@form[:modalities]}
          type="select"
          label="Modalities"
          prompt="Choose a value"
          options={Ecto.Enum.values(Mindfullove.Psychologists.Psychologist, :modalities)}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Psychologist</.button>
        </:actions>
      </.simple_form>
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
end
