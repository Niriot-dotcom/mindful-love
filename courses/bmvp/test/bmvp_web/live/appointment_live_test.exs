defmodule BmvpWeb.AppointmentLiveTest do
  use BmvpWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bmvp.AppointmentsFixtures

  @create_attrs %{status: "some status", date: "2024-02-18T19:50:00"}
  @update_attrs %{status: "some updated status", date: "2024-02-19T19:50:00"}
  @invalid_attrs %{status: nil, date: nil}

  defp create_appointment(_) do
    appointment = appointment_fixture()
    %{appointment: appointment}
  end

  describe "Index" do
    setup [:create_appointment]

    test "lists all appointments", %{conn: conn, appointment: appointment} do
      {:ok, _index_live, html} = live(conn, ~p"/appointments")

      assert html =~ "Listing Appointments"
      assert html =~ appointment.status
    end

    test "saves new appointment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/appointments")

      assert index_live |> element("a", "New Appointment") |> render_click() =~
               "New Appointment"

      assert_patch(index_live, ~p"/appointments/new")

      assert index_live
             |> form("#appointment-form", appointment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#appointment-form", appointment: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/appointments")

      html = render(index_live)
      assert html =~ "Appointment created successfully"
      assert html =~ "some status"
    end

    test "updates appointment in listing", %{conn: conn, appointment: appointment} do
      {:ok, index_live, _html} = live(conn, ~p"/appointments")

      assert index_live |> element("#appointments-#{appointment.id} a", "Edit") |> render_click() =~
               "Edit Appointment"

      assert_patch(index_live, ~p"/appointments/#{appointment}/edit")

      assert index_live
             |> form("#appointment-form", appointment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#appointment-form", appointment: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/appointments")

      html = render(index_live)
      assert html =~ "Appointment updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes appointment in listing", %{conn: conn, appointment: appointment} do
      {:ok, index_live, _html} = live(conn, ~p"/appointments")

      assert index_live |> element("#appointments-#{appointment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#appointments-#{appointment.id}")
    end
  end

  describe "Show" do
    setup [:create_appointment]

    test "displays appointment", %{conn: conn, appointment: appointment} do
      {:ok, _show_live, html} = live(conn, ~p"/appointments/#{appointment}")

      assert html =~ "Show Appointment"
      assert html =~ appointment.status
    end

    test "updates appointment within modal", %{conn: conn, appointment: appointment} do
      {:ok, show_live, _html} = live(conn, ~p"/appointments/#{appointment}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Appointment"

      assert_patch(show_live, ~p"/appointments/#{appointment}/show/edit")

      assert show_live
             |> form("#appointment-form", appointment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#appointment-form", appointment: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/appointments/#{appointment}")

      html = render(show_live)
      assert html =~ "Appointment updated successfully"
      assert html =~ "some updated status"
    end
  end
end
