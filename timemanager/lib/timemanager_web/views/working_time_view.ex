defmodule TimeManagerWeb.WorkingTimeView do
  use TimeManagerWeb, :view
  use JaSerializer.PhoenixView

  attributes [:startTime, :endTime, :user_id]
end
