defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :username, :string
    field :email, :string
    field :role_id, :id
    field :team_id, :id
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role_id, :team_id])
    |> validate_required([:username, :email, :role_id])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:username, :email])
  end
end
