defmodule TimeManager.Time do
  import Ecto.Query, warn: false
  alias TimeManager.Repo
  alias TimeManager.Time.Clock
  alias TimeManager.Time.WorkingTime

  @doc """
  Gets a single clock.
  Raises `Ecto.NoResultsError` if the Clock does not exist.
  """
  def get_clock_by_userId!(userId) do
    query = from c in Clock,
    where: c.user_id == ^userId
    Repo.one!(query)
  end

  @doc """
  Creates a clock.
  """
  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  def delete_clocks_by_userId(user_id) do
    from(c in Clock, where: c.user_id == ^user_id)
    |> Repo.delete_all
  end

  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.
  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end

  #-----------------------------------------------------------------#

  @doc """
  Gets a single working_time.
  Raises `Ecto.NoResultsError` if the Working time does not exist.
  """
  def get_working_time!(id) do
    Repo.get!(WorkingTime, id)
  end

  def getOneWorkingTime!(userId, id) do
    query = from w in WorkingTime,
            where: w.id == ^id and w.user_id == ^userId
    Repo.one!(query)
  end
  #inutilisé
  def getAllWorkingTime(userId) do
    query = from w in WorkingTime,
    where: w.user_id == ^userId
    Repo.all(query)
  end

  def getAllWorkingTime!(userId, startTime, endTime) do
    query = from w in WorkingTime,
    where: w.user_id == ^userId
    query = if startTime != nil do
      from w in query,
        where: w.startTime >= ^startTime
    end
    query = if endTime != nil do
      from w in query,
        where: w.endTime <= ^endTime
    end
    Repo.all(query)
  end
  @doc """
  Creates a working_time.
  """
  def create_working_time(attrs \\ %{}) do
    %WorkingTime{}
    |> WorkingTime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a working_time.
  """
  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  def delete_working_times_by_userId(user_id) do
    from(w in WorkingTime, where: w.user_id == ^user_id)
    |> Repo.delete_all
  end

  @doc """
  Deletes a working_time.
  """
  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_time changes.
  """
  def change_working_time(%WorkingTime{} = working_time, attrs \\ %{}) do
    WorkingTime.changeset(working_time, attrs)
  end
end
