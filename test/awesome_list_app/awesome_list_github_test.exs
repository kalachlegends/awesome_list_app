defmodule AwesomeListApp.AwesomeGithubTest do
  alias AwesomeListApp.Aggregate.GithubHelper
  use ExUnit.Case
  @github_repo_301 "epgsql/pooler"
  test "testing result 301" do
    assert {:ok, _result} = GithubHelper.get(@github_repo_301)
  end
end
