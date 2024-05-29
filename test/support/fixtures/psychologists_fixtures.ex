defmodule Mindfullove.PsychologistsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mindfullove.Psychologists` context.
  """

  @doc """
  Generate a psychologist.
  """
  def psychologist_fixture(attrs \\ %{}) do
    {:ok, psychologist} =
      attrs
      |> Enum.into(%{
        address: "some address",
        birthdate: ~N[2024-02-21 17:33:00],
        description: "some description",
        first_name: "some first_name",
        last_name: "some last_name",
        modalities: :IN_PERSON,
        occupation: "some occupation",
        specialties: ["option1", "option2"]
      })
      |> Mindfullove.Psychologists.create_psychologist()

    psychologist
  end
end
