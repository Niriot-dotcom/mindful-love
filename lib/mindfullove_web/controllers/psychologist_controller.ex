defmodule MindfulloveWeb.PsychologistController do
  use MindfulloveWeb, :controller

  alias Mindfullove.Accounts
  alias Mindfullove.Accounts.Psychologist

  def index(conn, _params) do
    psychologists = Accounts.list_psychologists()
    render(conn, :index, psychologists: psychologists)
  end

  def new(conn, _params) do
    changeset = Accounts.change_psychologist(%Psychologist{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"psychologist" => psychologist_params}) do
    case Accounts.create_psychologist(psychologist_params) do
      {:ok, psychologist} ->
        conn
        |> put_flash(:info, "Psychologist created successfully.")
        |> redirect(to: ~p"/psychologists/#{psychologist}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    psychologist = Accounts.get_psychologist!(id)
    render(conn, :show, psychologist: psychologist)
  end

  def edit(conn, %{"id" => id}) do
    psychologist = Accounts.get_psychologist!(id)
    changeset = Accounts.change_psychologist(psychologist)
    render(conn, :edit, psychologist: psychologist, changeset: changeset)
  end

  def update(conn, %{"id" => id, "psychologist" => psychologist_params}) do
    psychologist = Accounts.get_psychologist!(id)

    case Accounts.update_psychologist(psychologist, psychologist_params) do
      {:ok, psychologist} ->
        conn
        |> put_flash(:info, "Psychologist updated successfully.")
        |> redirect(to: ~p"/psychologists/#{psychologist}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, psychologist: psychologist, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    psychologist = Accounts.get_psychologist!(id)
    {:ok, _psychologist} = Accounts.delete_psychologist(psychologist)

    conn
    |> put_flash(:info, "Psychologist deleted successfully.")
    |> redirect(to: ~p"/psychologists")
  end
end
