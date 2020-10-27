defmodule TimeManagerWeb.ClockView do
  use TimeManagerWeb, :view
  use JaSerializer.PhoenixView

  attributes [:time, :status, :user_id]
end
