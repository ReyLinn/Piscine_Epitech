defmodule TimeManager.Accounts do
  require Logger
  import Ecto.Query, warn: false
  alias TimeManager.Repo
  alias TimeManager.Accounts.User
  alias TimeManager.Accounts.Team
  alias TimeManager.Time

  def get_user_by_email!(email, username) do
    query = from u in User,
    where: u.email == ^email and u.username == ^username
    Repo.one!(query)
  end
  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.
  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_users_of_team(teamId) do
    from(u in User, where: u.team_id == ^teamId)
    |> Repo.all
  end

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  """
  def update_user(%User{} = user, attrs) do
    old_role_id = user.role_id
    new_role_id = Map.get(attrs, "role_id")
    Logger.info(old_role_id)
    Logger.info(new_role_id)
    if old_role_id == 3  and new_role_id == 2 do
      Logger.info("----------------ALLO-------------")
      create_team(%{"manager_id" => user.id})
    end
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.
  """
  def delete_user(%User{} = user) do
    Time.delete_clocks_by_userId(user.id)
    Time.delete_working_times_by_userId(user.id)
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
  #-----------------------------------------------------------#

  def get_all_teams() do
    Repo.all(Team)
  end

  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  def get_team_by_manager(managerId) do
    from(t in Team, where: t.manager_id == ^managerId)
    |>Repo.one!
  end

  def get_users_of_team(teamId) do
    from(u in User, where: u.team_id == ^teamId)
    |>Repo.all
  end
end
