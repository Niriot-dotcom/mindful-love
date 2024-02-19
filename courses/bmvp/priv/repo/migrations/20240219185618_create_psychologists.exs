defmodule Bmvp.Repo.Migrations.CreatePsychologists do
  use Ecto.Migration

  def change do
    create table(:psychologists, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :text
      add :last_name, :text
      add :age, :integer
      add :location, :text
      add :yoe, :integer
      add :career, :text

      timestamps(type: :utc_datetime)
    end
  end
end
