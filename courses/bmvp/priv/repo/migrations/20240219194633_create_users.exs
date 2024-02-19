defmodule Bmvp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :text
      add :last_name, :text
      add :phone_number, :text

      timestamps(type: :utc_datetime)
    end
  end
end
