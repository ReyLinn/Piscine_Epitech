defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller
  require Logger
  alias TimeManager.Time
  alias TimeManager.Time.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  def show_one(conn, %{"userId" => userId, "workingTimeId" => wtId}) do
    working_time = Time.getOneWorkingTime!(userId, wtId)
    render(conn, "show.json", data: working_time)
  end

  def show_all(conn, %{"userId" => userId, "startTime" => startTime, "endTime" => endTime}) do
    working_time = Time.getAllWorkingTime!(userId, startTime, endTime)
    render(conn, "show.json", data: working_time)
  end

  def create(conn, %{"userId" => userId, "working_time" => working_time_params}) do
    newMap = Map.merge(working_time_params, %{"user_id" => userId})
    with {:ok, %WorkingTime{} = working_time} <- Time.create_working_time(newMap) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show_one, working_time.user_id, working_time.id))
      |> render("show.json", data: working_time)
    end
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = Time.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- Time.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", data: working_time)
    end
  end

  def delete(conn, %{"workingTimeId" => id}) do
    working_time = Time.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- Time.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
