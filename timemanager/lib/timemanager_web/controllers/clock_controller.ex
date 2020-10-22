defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Time
  alias TimeManager.Time.Clock

  action_fallback TimeManagerWeb.FallbackController

  def show(conn, %{"userId" => userId}) do
    clock = Time.get_clock_by_userId!(userId)
    render(conn, "show.json", data: clock)
  end

  def create(conn, %{"userId" => userId, "clock" => clock_params}) do
    newMap = Map.merge(clock_params, %{"user_id" => userId})
    with {:ok, %Clock{} = clock} <- Time.create_clock(newMap) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", data: clock)
    end
  end
end
