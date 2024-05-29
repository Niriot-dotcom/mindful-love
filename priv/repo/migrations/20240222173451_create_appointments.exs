defmodule Mindfullove.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :date, :naive_datetime
      add :status, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :psychologist_id, references(:psychologists, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:appointments, [:user_id])
    create index(:appointments, [:psychologist_id])
  end
end
