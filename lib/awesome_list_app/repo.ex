defmodule AwesomeListApp.Repo do
  use Ecto.Repo,
    otp_app: :awesome_list_app,
    adapter: Ecto.Adapters.Postgres
end
