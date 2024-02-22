defmodule Mindfullove.Psychologists do
  @moduledoc """
  The Psychologists context.
  """

  import Ecto.Query, warn: false
  alias Mindfullove.Repo

  alias Mindfullove.Psychologists.Psychologist

  @doc """
  Returns the list of psychologists.

  ## Examples

      iex> list_psychologists()
      [%Psychologist{}, ...]

  """
  def list_psychologists do
    Repo.all(Psychologist)
  end

  @doc """
  Gets a single psychologist.

  Raises `Ecto.NoResultsError` if the Psychologist does not exist.

  ## Examples

      iex> get_psychologist!(123)
      %Psychologist{}

      iex> get_psychologist!(456)
      ** (Ecto.NoResultsError)

  """
  def get_psychologist!(id), do: Repo.get!(Psychologist, id)

  @doc """
  Creates a psychologist.

  ## Examples

      iex> create_psychologist(%{field: value})
      {:ok, %Psychologist{}}

      iex> create_psychologist(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_psychologist(attrs \\ %{}) do
    %Psychologist{}
    |> Psychologist.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a psychologist.

  ## Examples

      iex> update_psychologist(psychologist, %{field: new_value})
      {:ok, %Psychologist{}}

      iex> update_psychologist(psychologist, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_psychologist(%Psychologist{} = psychologist, attrs) do
    psychologist
    |> Psychologist.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a psychologist.

  ## Examples

      iex> delete_psychologist(psychologist)
      {:ok, %Psychologist{}}

      iex> delete_psychologist(psychologist)
      {:error, %Ecto.Changeset{}}

  """
  def delete_psychologist(%Psychologist{} = psychologist) do
    Repo.delete(psychologist)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking psychologist changes.

  ## Examples

      iex> change_psychologist(psychologist)
      %Ecto.Changeset{data: %Psychologist{}}

  """
  def change_psychologist(%Psychologist{} = psychologist, attrs \\ %{}) do
    Psychologist.changeset(psychologist, attrs)
  end
end
