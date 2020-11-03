defmodule TimeManager.Accounts do
  require Logger
  import Ecto.Query, warn: false
  alias TimeManager.Repo
  alias TimeManager.Accounts.User
  alias TimeManager.Accounts.Team
  alias TimeManager.Accounts.Role
  alias TimeManager.Time

  def get_all_users() do
    from(u in User, where: u.role_id != 1)
    |>Repo.all
  end

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

  def get_users_no_team() do
    from(u in User, where: is_nil(u.team_id))
    |> Repo.all
  end

#inutilisé
  def create_user_and_clock(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
    |> Time.create_clock()
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
    role_employee_id =
      from(r in Role, where: r.name == ^"Employee", select: r.id)
      |> Repo.one!
    role_manager_id =
      from(r in Role, where: r.name == ^"Manager", select: r.id)
      |> Repo.one!
    if old_role_id == role_employee_id  and new_role_id == role_manager_id do
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
    if user.role_id == 2 do
      team_query = from t in Team, where: t.manager_id == ^user.id
      team_to_delete = Repo.one!(team_query)
      users_query = from u in User, where: u.team_id == ^team_to_delete.id
      users = Repo.all(users_query)
      Enum.each(users, fn user ->
        update_user(user, %{"team_id" => nil})
      end)
      Repo.delete(team_to_delete)
    end
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.
  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def authenticate_user(email, password) do
    query = from(u in User, where: u.email == ^email)
    query |> Repo.one() |> verify_password(password)
  end

  defp verify_password(nil, _) do
    # Perform a dummy check to make user enumeration more difficult
    Bcrypt.no_user_verify()
    {:error, "Wrong email or password"}
  end

  defp verify_password(user, password) do
    if Bcrypt.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, "Wrong email or password"}
    end
  end
  #-----------------------------------------------------------#

  def get_all_teams() do
    Repo.all(Team)
  end

  def update_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.update()
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
end
