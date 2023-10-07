defmodule AwesomeListAppWeb.PageController do
  use AwesomeListAppWeb, :controller
  import Ecto.Query

  def home(conn, %{"min_stars" => stars}) do
    # The home page is often custom made,
    # so skip the default app layout.
    stars = String.to_integer(stars)

    render(conn, :home,
      layout: false,
      list_category:
        AwesomeListApp.Model.CategoryRepo.get_all!(%{
          use_query: %{
            preload: [
              list_repo:
                from(rep in AwesomeListApp.Model.Repository,
                  where: rep.stars >= ^stars
                )
            ]
          }
        })
    )
  end

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home,
      layout: false,
      list_category:
        AwesomeListApp.Model.CategoryRepo.get_all!(%{use_query: %{preload: [:list_repo]}})
    )
  end
end
