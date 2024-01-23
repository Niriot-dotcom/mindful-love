defmodule MindfulloveWeb.UserControllerTest do
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

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/psychologists/new")
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/psychologists", user: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/psychologists/#{id}"

      conn = get(conn, ~p"/psychologists/#{id}")
      assert html_response(conn, 200) =~ "User #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/psychologists", user: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "edit user" do
    setup [:create_user]

    test "renders form for editing chosen user", %{conn: conn, user: user} do
      conn = get(conn, ~p"/psychologists/#{user}/edit")
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    setup [:create_user]

    test "redirects when data is valid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/psychologists/#{user}", user: @update_attrs)
      assert redirected_to(conn) == ~p"/psychologists/#{user}"

      conn = get(conn, ~p"/psychologists/#{user}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/psychologists/#{user}", user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/psychologists/#{user}")
      assert redirected_to(conn) == ~p"/psychologists"

      assert_error_sent 404, fn ->
        get(conn, ~p"/psychologists/#{user}")
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
