defmodule AwesomeListAppWeb.PageControllerTest do
  use AwesomeListAppWeb.ConnCase

  test "GET /", %{conn: conn} do
    test_readme = AwesomeListAppWeb.ReadmeGithub.test()

    conn = get(conn, ~p"/")
    assert html_response(conn, 200)

    AwesomeListApp.start(test_readme)

    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Actors"
    assert html_response(conn, 200) =~ "spawn"
    assert html_response(conn, 200) =~ "Count days on last commit"
    assert html_response(conn, 200) =~ "Elixir poliglot"
  end

  test "GET /?min_stars=100000", %{conn: conn} do
    test_readme = AwesomeListAppWeb.ReadmeGithub.test()
    AwesomeListApp.start(test_readme)
    conn = get(conn, ~p"/?min_stars=10000")

    assert html_response(conn, 200) =~ "No doesn't have library with stars"
  end
end
