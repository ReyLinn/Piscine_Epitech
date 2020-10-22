defmodule TimeManager.Time.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :startTime, :utc_datetime
    field :endTime, :utc_datetime
    field :user_id, :id
    timestamps()
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:startTime, :endTime, :user_id])
    |> validate_required([:startTime, :endTime, :user_id])
  end
end
