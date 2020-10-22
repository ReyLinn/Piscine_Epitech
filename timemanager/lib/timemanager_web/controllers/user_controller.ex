defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller
  require Logger
  alias TimeManager.Accounts
  alias TimeManager.Accounts.User
  alias TimeManager.Time

  action_fallback TimeManagerWeb.FallbackController

  def show_all(conn, %{}) do
    users = Accounts.get_all_users() #except General Manager
    render(conn, "show.json", data: users)
  end

  def show(conn, %{"email" => email, "username" => username}) do
    user = Accounts.get_user_by_email!(email, username)
    render(conn, "show.json", data: user)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", data: user)
  end

  def show(conn, %{"teamId" => teamId}) do
    users = if teamId != "0" do
        Accounts.get_users_of_team(teamId)
      else
        Accounts.get_users_no_team()
      end
    render(conn, "show.json", data: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      clock_params = %{"time" => DateTime.truncate(DateTime.utc_now(), :second), "status" => false, "user_id" => user.id}
      Time.create_clock(clock_params)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user.id))
      |> render("show.json", data: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", data: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
