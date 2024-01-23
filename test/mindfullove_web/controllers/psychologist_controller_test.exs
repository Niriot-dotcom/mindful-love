defmodule MindfulloveWeb.PsychologistControllerTest do
  use MindfulloveWeb.ConnCase

  import Mindfullove.AccountsFixtures

  @create_attrs %{name: "some name", last_name: "some last_name", phone_number: "some phone_number", profession: "some profession"}
  @update_attrs %{name: "some updated name", last_name: "some updated last_name", phone_number: "some updated phone_number", profession: "some updated profession"}
  @invalid_attrs %{name: nil, last_name: nil, phone_number: nil, profession: nil}

  describe "index" do
    test "lists all psychologists", %{conn: conn} do
      conn = get(conn, ~p"/psychologists")
      assert html_response(conn, 200) =~ "Listing Psychologists"
    end
  end

  describe "new psychologist" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/psychologists/new")
      assert html_response(conn, 200) =~ "New Psychologist"
    end
  end

  describe "create psychologist" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/psychologists", psychologist: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/psychologists/#{id}"

      conn = get(conn, ~p"/psychologists/#{id}")
      assert html_response(conn, 200) =~ "Psychologist #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/psychologists", psychologist: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Psychologist"
    end
  end

  describe "edit psychologist" do
    setup [:create_psychologist]

    test "renders form for editing chosen psychologist", %{conn: conn, psychologist: psychologist} do
      conn = get(conn, ~p"/psychologists/#{psychologist}/edit")
      assert html_response(conn, 200) =~ "Edit Psychologist"
    end
  end

  describe "update psychologist" do
    setup [:create_psychologist]

    test "redirects when data is valid", %{conn: conn, psychologist: psychologist} do
      conn = put(conn, ~p"/psychologists/#{psychologist}", psychologist: @update_attrs)
      assert redirected_to(conn) == ~p"/psychologists/#{psychologist}"

      conn = get(conn, ~p"/psychologists/#{psychologist}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, psychologist: psychologist} do
      conn = put(conn, ~p"/psychologists/#{psychologist}", psychologist: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Psychologist"
    end
  end

  describe "delete psychologist" do
    setup [:create_psychologist]

    test "deletes chosen psychologist", %{conn: conn, psychologist: psychologist} do
      conn = delete(conn, ~p"/psychologists/#{psychologist}")
      assert redirected_to(conn) == ~p"/psychologists"

      assert_error_sent 404, fn ->
        get(conn, ~p"/psychologists/#{psychologist}")
      end
    end
  end

  defp create_psychologist(_) do
    psychologist = psychologist_fixture()
    %{psychologist: psychologist}
  end
end
