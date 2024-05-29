defmodule Mindfullove.PsychologistsTest do
  use Mindfullove.DataCase

  alias Mindfullove.Psychologists

  describe "psychologists" do
    alias Mindfullove.Psychologists.Psychologist

    import Mindfullove.PsychologistsFixtures

    @invalid_attrs %{address: nil, description: nil, first_name: nil, last_name: nil, birthdate: nil, occupation: nil, specialties: nil, modalities: nil}

    test "list_psychologists/0 returns all psychologists" do
      psychologist = psychologist_fixture()
      assert Psychologists.list_psychologists() == [psychologist]
    end

    test "get_psychologist!/1 returns the psychologist with given id" do
      psychologist = psychologist_fixture()
      assert Psychologists.get_psychologist!(psychologist.id) == psychologist
    end

    test "create_psychologist/1 with valid data creates a psychologist" do
      valid_attrs = %{address: "some address", description: "some description", first_name: "some first_name", last_name: "some last_name", birthdate: ~N[2024-02-21 17:33:00], occupation: "some occupation", specialties: ["option1", "option2"], modalities: :IN_PERSON}

      assert {:ok, %Psychologist{} = psychologist} = Psychologists.create_psychologist(valid_attrs)
      assert psychologist.address == "some address"
      assert psychologist.description == "some description"
      assert psychologist.first_name == "some first_name"
      assert psychologist.last_name == "some last_name"
      assert psychologist.birthdate == ~N[2024-02-21 17:33:00]
      assert psychologist.occupation == "some occupation"
      assert psychologist.specialties == ["option1", "option2"]
      assert psychologist.modalities == :IN_PERSON
    end

    test "create_psychologist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Psychologists.create_psychologist(@invalid_attrs)
    end

    test "update_psychologist/2 with valid data updates the psychologist" do
      psychologist = psychologist_fixture()
      update_attrs = %{address: "some updated address", description: "some updated description", first_name: "some updated first_name", last_name: "some updated last_name", birthdate: ~N[2024-02-22 17:33:00], occupation: "some updated occupation", specialties: ["option1"], modalities: :HYBRID}

      assert {:ok, %Psychologist{} = psychologist} = Psychologists.update_psychologist(psychologist, update_attrs)
      assert psychologist.address == "some updated address"
      assert psychologist.description == "some updated description"
      assert psychologist.first_name == "some updated first_name"
      assert psychologist.last_name == "some updated last_name"
      assert psychologist.birthdate == ~N[2024-02-22 17:33:00]
      assert psychologist.occupation == "some updated occupation"
      assert psychologist.specialties == ["option1"]
      assert psychologist.modalities == :HYBRID
    end

    test "update_psychologist/2 with invalid data returns error changeset" do
      psychologist = psychologist_fixture()
      assert {:error, %Ecto.Changeset{}} = Psychologists.update_psychologist(psychologist, @invalid_attrs)
      assert psychologist == Psychologists.get_psychologist!(psychologist.id)
    end

    test "delete_psychologist/1 deletes the psychologist" do
      psychologist = psychologist_fixture()
      assert {:ok, %Psychologist{}} = Psychologists.delete_psychologist(psychologist)
      assert_raise Ecto.NoResultsError, fn -> Psychologists.get_psychologist!(psychologist.id) end
    end

    test "change_psychologist/1 returns a psychologist changeset" do
      psychologist = psychologist_fixture()
      assert %Ecto.Changeset{} = Psychologists.change_psychologist(psychologist)
    end
  end
end
