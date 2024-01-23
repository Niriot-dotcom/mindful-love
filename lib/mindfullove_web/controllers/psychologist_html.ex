defmodule MindfulloveWeb.PsychologistHTML do
  use MindfulloveWeb, :html

  embed_templates "psychologist_html/*"

  @doc """
  Renders a psychologist form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def psychologist_form(assigns)
end
