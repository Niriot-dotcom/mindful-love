defmodule Mindfullove.Repo.Migrations.CreatePsychologists do
  use Ecto.Migration

  def change do
    create table(:psychologists) do
      add :first_name, :string
      add :last_name, :string
      add :description, :string
      add :birthdate, :naive_datetime
      add :address, :string
      add :occupation, :string
      add :specialties, {:array, :string}
      add :modalities, :string

      timestamps(type: :utc_datetime)
    end
  end
end
