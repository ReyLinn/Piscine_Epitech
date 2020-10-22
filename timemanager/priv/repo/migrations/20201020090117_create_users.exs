defmodule TimeManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :role_id, references(:roles, ondelete: :nothing), null: false
      add :team_id, references(:teams, ondelete: :nothing)
      timestamps()
    end
    create unique_index(:users, [:username, :email])

    alter table(:teams) do
      add :manager_id, references(:users, ondelete: :nothing), null: false
    end
    create unique_index(:teams, [:manager_id])
  end
end
