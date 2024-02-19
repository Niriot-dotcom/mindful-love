defmodule BmvpWeb.PsychologistLive.Index do
  use BmvpWeb, :live_view

  alias Bmvp.Psychologists
  alias Bmvp.Psychologists.Psychologist

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :psychologists, Psychologists.list_psychologists())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Psychologist")
    |> assign(:psychologist, Psychologists.get_psychologist!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Psychologist")
    |> assign(:psychologist, %Psychologist{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Psychologists")
    |> assign(:psychologist, nil)
  end

  @impl true
  def handle_info({BmvpWeb.PsychologistLive.FormComponent, {:saved, psychologist}}, socket) do
    {:noreply, stream_insert(socket, :psychologists, psychologist)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    psychologist = Psychologists.get_psychologist!(id)
    {:ok, _} = Psychologists.delete_psychologist(psychologist)

    {:noreply, stream_delete(socket, :psychologists, psychologist)}
  end
end
