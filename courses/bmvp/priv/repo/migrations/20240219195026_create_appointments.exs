defmodule Bmvp.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :date, :naive_datetime
      add :status, :text
      # add :user_id, references(:accounts, on_delete: :nothing, type: :binary_id)
      add :user_id, :binary_id
      add :psychologist_id, references(:psychologists, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:appointments, [:user_id])
    create index(:appointments, [:psychologist_id])
  end
end
