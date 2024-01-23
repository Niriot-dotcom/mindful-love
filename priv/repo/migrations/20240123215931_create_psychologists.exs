defmodule Mindfullove.Repo.Migrations.CreatePsychologists do
  use Ecto.Migration

  def change do
    create table(:psychologists) do
      add :name, :string
      add :last_name, :string
      add :phone_number, :string
      add :profession, :string

      timestamps(type: :utc_datetime)
    end
  end
end
