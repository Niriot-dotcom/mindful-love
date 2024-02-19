defmodule Bmvp.PsychologistsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bmvp.Psychologists` context.
  """

  @doc """
  Generate a psychologist.
  """
  def psychologist_fixture(attrs \\ %{}) do
    {:ok, psychologist} =
      attrs
      |> Enum.into(%{
        age: 42,
        career: "some career",
        first_name: "some first_name",
        last_name: "some last_name",
        location: "some location",
        yoe: 42
      })
      |> Bmvp.Psychologists.create_psychologist()

    psychologist
  end
end
