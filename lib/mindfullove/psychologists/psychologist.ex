defmodule Mindfullove.Psychologists.Psychologist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "psychologists" do
    field :address, :string
    field :description, :string
    field :first_name, :string
    field :last_name, :string
    field :birthdate, :naive_datetime
    field :occupation, :string
    field :specialties, {:array, :string}
    field :modalities, Ecto.Enum, values: [:IN_PERSON, :HYBRID, :ONLINE]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(psychologist, attrs) do
    psychologist
    |> cast(attrs, [:first_name, :last_name, :description, :birthdate, :address, :occupation, :specialties, :modalities])
    |> validate_required([:first_name, :last_name, :description, :birthdate, :address, :occupation, :specialties, :modalities])
  end
end
