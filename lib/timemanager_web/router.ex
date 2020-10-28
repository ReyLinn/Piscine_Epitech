defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :json_api do
    plug :accepts, ["json-api"]
    plug JaSerializer.Deserializer
  end

  scope "/api", TimeManagerWeb do
    pipe_through :json_api

    get "/users", UserController, :show
    get "/users/all", UserController, :show_all
    get "/users/:id", UserController, :show
    get "/users/teams/:teamId", UserController, :show
    post "/users", UserController, :create
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete

    get "/workingtimes/:userId", WorkingTimeController, :show_all
    get "/workingtimes/:userId/:workingTimeId", WorkingTimeController, :show_one
    post "/workingtimes/:userId", WorkingTimeController, :create
    put "/workingtimes/:id", WorkingTimeController, :update
    delete "/workingtimes/:workingTimeId", WorkingTimeController, :delete

    get "/clocks/:userId", ClockController, :show
    put "/clocks/:userId", ClockController, :update

    get "/teams", TeamController, :index
    get "/teams/:managerId", TeamController, :show
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: TimeManagerWeb.Telemetry
    end
  end
end
