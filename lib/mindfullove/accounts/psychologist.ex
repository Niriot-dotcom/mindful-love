defmodule Mindfullove.Accounts.Psychologist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "psychologists" do
    field :name, :string
    field :last_name, :string
    field :phone_number, :string
    field :profession, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(psychologist, attrs) do
    psychologist
    |> cast(attrs, [:name, :last_name, :phone_number, :profession])
    |> validate_required([:name, :last_name, :phone_number, :profession])
  end
end
