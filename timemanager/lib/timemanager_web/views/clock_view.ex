defmodule TimeManagerWeb.ClockView do
  use TimeManagerWeb, :view
  use JaSerializer.PhoenixView
  
  attributes [:time, :status, :user_id]
@doc """
  alias TimeManagerWeb.ClockView
  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{id: clock.id,
      time: clock.time,
      status: clock.status,
      user_id: clock.user_id}
  end
  """
end
