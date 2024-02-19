defmodule Bmvp.Psychologists.Psychologist do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "psychologists" do
    field :location, :string
    field :first_name, :string
    field :last_name, :string
    field :age, :integer
    field :yoe, :integer
    field :career, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(psychologist, attrs) do
    psychologist
    |> cast(attrs, [:first_name, :last_name, :age, :location, :yoe, :career])
    |> validate_required([:first_name, :last_name, :age, :location, :yoe, :career])
  end
end
