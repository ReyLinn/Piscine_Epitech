defmodule TimeManager.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :startTime, :naive_datetime, null: false
      add :endTime, :naive_datetime, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      timestamps()
    end
    create index(:workingtimes, [:user_id])
  end
end
