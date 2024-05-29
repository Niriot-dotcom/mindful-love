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

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Mindfullove.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
