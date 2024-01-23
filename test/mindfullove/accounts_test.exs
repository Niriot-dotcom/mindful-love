defmodule Mindfullove.AccountsTest do
  use Mindfullove.DataCase

  alias Mindfullove.Accounts

  describe "psychologists" do
    alias Mindfullove.Accounts.User

    import Mindfullove.AccountsFixtures

    @invalid_attrs %{name: nil, last_name: nil, phone_number: nil, profession: nil}

    test "list_psychologists/0 returns all psychologists" do
      user = user_fixture()
      assert Accounts.list_psychologists() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", last_name: "some last_name", phone_number: "some phone_number", profession: "some profession"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.last_name == "some last_name"
      assert user.phone_number == "some phone_number"
      assert user.profession == "some profession"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name", last_name: "some updated last_name", phone_number: "some updated phone_number", profession: "some updated profession"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.last_name == "some updated last_name"
      assert user.phone_number == "some updated phone_number"
      assert user.profession == "some updated profession"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "psychologists" do
    alias Mindfullove.Accounts.Psychologist

    import Mindfullove.AccountsFixtures

    @invalid_attrs %{name: nil, last_name: nil, phone_number: nil, profession: nil}

    test "list_psychologists/0 returns all psychologists" do
      psychologist = psychologist_fixture()
      assert Accounts.list_psychologists() == [psychologist]
    end

    test "get_psychologist!/1 returns the psychologist with given id" do
      psychologist = psychologist_fixture()
      assert Accounts.get_psychologist!(psychologist.id) == psychologist
    end

    test "create_psychologist/1 with valid data creates a psychologist" do
      valid_attrs = %{name: "some name", last_name: "some last_name", phone_number: "some phone_number", profession: "some profession"}

      assert {:ok, %Psychologist{} = psychologist} = Accounts.create_psychologist(valid_attrs)
      assert psychologist.name == "some name"
      assert psychologist.last_name == "some last_name"
      assert psychologist.phone_number == "some phone_number"
      assert psychologist.profession == "some profession"
    end

    test "create_psychologist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_psychologist(@invalid_attrs)
    end

    test "update_psychologist/2 with valid data updates the psychologist" do
      psychologist = psychologist_fixture()
      update_attrs = %{name: "some updated name", last_name: "some updated last_name", phone_number: "some updated phone_number", profession: "some updated profession"}

      assert {:ok, %Psychologist{} = psychologist} = Accounts.update_psychologist(psychologist, update_attrs)
      assert psychologist.name == "some updated name"
      assert psychologist.last_name == "some updated last_name"
      assert psychologist.phone_number == "some updated phone_number"
      assert psychologist.profession == "some updated profession"
    end

    test "update_psychologist/2 with invalid data returns error changeset" do
      psychologist = psychologist_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_psychologist(psychologist, @invalid_attrs)
      assert psychologist == Accounts.get_psychologist!(psychologist.id)
    end

    test "delete_psychologist/1 deletes the psychologist" do
      psychologist = psychologist_fixture()
      assert {:ok, %Psychologist{}} = Accounts.delete_psychologist(psychologist)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_psychologist!(psychologist.id) end
    end

    test "change_psychologist/1 returns a psychologist changeset" do
      psychologist = psychologist_fixture()
      assert %Ecto.Changeset{} = Accounts.change_psychologist(psychologist)
    end
  end
end
