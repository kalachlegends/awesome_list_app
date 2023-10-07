defmodule AwesomeListApp.AwesomeListTest do
  use ExUnit.Case
  @github_repository_test "h4cc/awesome-elixir"
  @github_repository_test_kalachlegend "kalachlegends/nurse_umbrella"
  @some_failed_repository "kalachlegends312321/213321321asdsad"
  test "GET README TEST FROM CONFIG REPOSTIORY AWESOME LIST" do
    assert {:ok, _readme} = AwesomeListApp.Aggregate.get_readme()
  end

  test "get information site (stars, link) test by type" do
    func_test_by_repository = fn x ->
      result =
        AwesomeListApp.Aggregate.get_information_from_sites(%{
          "type" => "github",
          "link_without_host" => x,
          "name" => x
        })

      assert {:ok, %{"stars" => stars, "last_time_commit" => _last_time_commit}} = result

      assert is_integer(stars)
    end

    func_test_by_repository.(@github_repository_test)
    func_test_by_repository.(@github_repository_test_kalachlegend)

    result =
      AwesomeListApp.Aggregate.get_information_from_sites(%{
        "type" => "github",
        "link_without_host" => @some_failed_repository
      })

    assert {:error, _} = result
  end

  test "Parse test readme " do
    test_readme = AwesomeListAppWeb.ReadmeGithub.test()

    assert {:ok, list_category} = AwesomeListApp.Aggregate.parse_readme(test_readme)

    category_actors =
      list_category
      |> Enum.find(fn x -> x["name_category"] == "Actors" end)

    assert %{"name_category" => "Actors"} = category_actors

    assert %{"name_category" => "Actors", "list_libraries" => list_libraries} = category_actors

    one_library = List.first(list_libraries)

    assert {:ok, %{"name" => _name, "description" => _description, "stars" => stars}} =
             one_library

    assert is_integer(stars)
  end
end
