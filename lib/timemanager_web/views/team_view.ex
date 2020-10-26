defmodule TimeManagerWeb.TeamView do
  use TimeManagerWeb, :view
  use JaSerializer.PhoenixView

  attributes [:manager_id]
end
