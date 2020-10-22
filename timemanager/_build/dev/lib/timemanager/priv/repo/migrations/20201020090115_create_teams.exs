defmodule TimeManager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :manager_id, :references(:users, ondelete: :nothing), null: false

      timestamps()
    end
    create unique_index(:teams, [:manager_id])
  end
end
