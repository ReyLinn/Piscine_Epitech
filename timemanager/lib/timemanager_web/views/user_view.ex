defmodule TimeManagerWeb.UserView do
  use TimeManagerWeb, :view
  use JaSerializer.PhoenixView

  attributes [:email, :username, :role_id, :team_id]
end
