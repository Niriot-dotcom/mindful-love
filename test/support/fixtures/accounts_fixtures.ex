defmodule Mindfullove.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mindfullove.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        last_name: "some last_name",
        name: "some name",
        phone_number: "some phone_number",
        profession: "some profession"
      })
      |> Mindfullove.Accounts.create_user()

    user
  end

  @doc """
  Generate a psychologist.
  """
  def psychologist_fixture(attrs \\ %{}) do
    {:ok, psychologist} =
      attrs
      |> Enum.into(%{
        last_name: "some last_name",
        name: "some name",
        phone_number: "some phone_number",
        profession: "some profession"
      })
      |> Mindfullove.Accounts.create_psychologist()

    psychologist
  end
end
