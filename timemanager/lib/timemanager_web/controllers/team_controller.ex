defmodule TimeManagerWeb.TeamController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManager.Accounts.Team

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    teams = Accounts.get_all_teams()
    render(conn, "show.json", data: teams)
  end

  def show(conn, %{"managerId" => managerId}) do
    team = Accounts.get_team_by_manager(managerId)
    render(conn, "show.json", data: team)
  end
end
