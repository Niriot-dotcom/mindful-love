defmodule MindfulloveWeb.PsychologistLiveTest do
  use MindfulloveWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mindfullove.PsychologistsFixtures

  @create_attrs %{address: "some address", description: "some description", first_name: "some first_name", last_name: "some last_name", birthdate: "2024-02-21T17:33:00", occupation: "some occupation", specialties: ["option1", "option2"], modalities: :IN_PERSON}
  @update_attrs %{address: "some updated address", description: "some updated description", first_name: "some updated first_name", last_name: "some updated last_name", birthdate: "2024-02-22T17:33:00", occupation: "some updated occupation", specialties: ["option1"], modalities: :HYBRID}
  @invalid_attrs %{address: nil, description: nil, first_name: nil, last_name: nil, birthdate: nil, occupation: nil, specialties: [], modalities: nil}

  defp create_psychologist(_) do
    psychologist = psychologist_fixture()
    %{psychologist: psychologist}
  end

  describe "Index" do
    setup [:create_psychologist]

    test "lists all psychologists", %{conn: conn, psychologist: psychologist} do
      {:ok, _index_live, html} = live(conn, ~p"/psychologists")

      assert html =~ "Listing Psychologists"
      assert html =~ psychologist.address
    end

    test "saves new psychologist", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/psychologists")

      assert index_live |> element("a", "New Psychologist") |> render_click() =~
               "New Psychologist"

      assert_patch(index_live, ~p"/psychologists/new")

      assert index_live
             |> form("#psychologist-form", psychologist: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#psychologist-form", psychologist: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/psychologists")

      html = render(index_live)
      assert html =~ "Psychologist created successfully"
      assert html =~ "some address"
    end

    test "updates psychologist in listing", %{conn: conn, psychologist: psychologist} do
      {:ok, index_live, _html} = live(conn, ~p"/psychologists")

      assert index_live |> element("#psychologists-#{psychologist.id} a", "Edit") |> render_click() =~
               "Edit Psychologist"

      assert_patch(index_live, ~p"/psychologists/#{psychologist}/edit")

      assert index_live
             |> form("#psychologist-form", psychologist: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#psychologist-form", psychologist: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/psychologists")

      html = render(index_live)
      assert html =~ "Psychologist updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes psychologist in listing", %{conn: conn, psychologist: psychologist} do
      {:ok, index_live, _html} = live(conn, ~p"/psychologists")

      assert index_live |> element("#psychologists-#{psychologist.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#psychologists-#{psychologist.id}")
    end
  end

  describe "Show" do
    setup [:create_psychologist]

    test "displays psychologist", %{conn: conn, psychologist: psychologist} do
      {:ok, _show_live, html} = live(conn, ~p"/psychologists/#{psychologist}")

      assert html =~ "Show Psychologist"
      assert html =~ psychologist.address
    end

    test "updates psychologist within modal", %{conn: conn, psychologist: psychologist} do
      {:ok, show_live, _html} = live(conn, ~p"/psychologists/#{psychologist}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Psychologist"

      assert_patch(show_live, ~p"/psychologists/#{psychologist}/show/edit")

      assert show_live
             |> form("#psychologist-form", psychologist: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#psychologist-form", psychologist: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/psychologists/#{psychologist}")

      html = render(show_live)
      assert html =~ "Psychologist updated successfully"
      assert html =~ "some updated address"
    end
  end
end
