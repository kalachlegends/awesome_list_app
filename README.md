# Awesome list ⭐⭐🌟
This is my test application for applying to the job.
## Technical task

Elixir, like many other languages, has its own "awesome list": h4cc/awesome-elixir. 
However, libraries added to it can become outdated, cease to be maintained, or, failing to gain significant popularity, start to be overshadowed by their counterparts.

To visually display the state of libraries in the awesome list for Elixir, you are invited to implement a web application that meets the following requirements.
### Elixir Web Application Requirements

### Application Overview
- The application is written in Elixir using the Phoenix framework.
- It consists of a single main page: `/`.
- On this page, information about Elixir libraries from the awesome list repository `h4cc/awesome-elixir` is displayed.
- This information is updated daily.

### Library Information
- Each library's description includes:
  - The number of stars it has on GitHub.
  - The number of days since its last commit on GitHub.

### Filtering by Stars
- The page accepts a parameter `min_stars`: `/?min_stars=50`.
- When this parameter is specified, only libraries with at least `min_stars` stars are displayed.
- If a section has no libraries after filtering by `min_stars`, the entire section is not displayed.

### Code Quality
- The code should be covered by tests.
- Instructions for running the application should be included in the README.

## install

```elixir
mix deps.get
mix ecto.create
mix ecto.migrate
iex -S mix phx.server

```



## Test

```elixir
mix test

```
