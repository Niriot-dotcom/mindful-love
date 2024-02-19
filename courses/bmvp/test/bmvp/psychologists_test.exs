defmodule Bmvp.PsychologistsTest do
  use Bmvp.DataCase

  alias Bmvp.Psychologists

  describe "psychologists" do
    alias Bmvp.Psychologists.Psychologist

    import Bmvp.PsychologistsFixtures

    @invalid_attrs %{location: nil, first_name: nil, last_name: nil, age: nil, yoe: nil, career: nil}

    test "list_psychologists/0 returns all psychologists" do
      psychologist = psychologist_fixture()
      assert Psychologists.list_psychologists() == [psychologist]
    end

    test "get_psychologist!/1 returns the psychologist with given id" do
      psychologist = psychologist_fixture()
      assert Psychologists.get_psychologist!(psychologist.id) == psychologist
    end

    test "create_psychologist/1 with valid data creates a psychologist" do
      valid_attrs = %{location: "some location", first_name: "some first_name", last_name: "some last_name", age: 42, yoe: 42, career: "some career"}

      assert {:ok, %Psychologist{} = psychologist} = Psychologists.create_psychologist(valid_attrs)
      assert psychologist.location == "some location"
      assert psychologist.first_name == "some first_name"
      assert psychologist.last_name == "some last_name"
      assert psychologist.age == 42
      assert psychologist.yoe == 42
      assert psychologist.career == "some career"
    end

    test "create_psychologist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Psychologists.create_psychologist(@invalid_attrs)
    end

    test "update_psychologist/2 with valid data updates the psychologist" do
      psychologist = psychologist_fixture()
      update_attrs = %{location: "some updated location", first_name: "some updated first_name", last_name: "some updated last_name", age: 43, yoe: 43, career: "some updated career"}

      assert {:ok, %Psychologist{} = psychologist} = Psychologists.update_psychologist(psychologist, update_attrs)
      assert psychologist.location == "some updated location"
      assert psychologist.first_name == "some updated first_name"
      assert psychologist.last_name == "some updated last_name"
      assert psychologist.age == 43
      assert psychologist.yoe == 43
      assert psychologist.career == "some updated career"
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
