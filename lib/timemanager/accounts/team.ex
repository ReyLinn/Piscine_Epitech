defmodule TimeManager.Accounts.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :manager_id, :id
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:manager_id])
    |> validate_required([:manager_id])
    |> unique_constraint([:manager_id])
  end
end
