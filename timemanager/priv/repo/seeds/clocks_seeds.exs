alias TimeManager.Repo
alias TimeManager.Time.Clock

Repo.insert! %Clock{
  time: DateTime.truncate(DateTime.utc_now(), :second),
  status: true,
  user_id: 1
}

Repo.insert! %Clock{
  time: DateTime.truncate(DateTime.utc_now(), :second),
  status: true,
  user_id: 2
}

Repo.insert! %Clock{
  time: DateTime.truncate(DateTime.utc_now(), :second),
  status: true,
  user_id: 3
}

Repo.insert! %Clock{
  time: DateTime.truncate(DateTime.utc_now(), :second),
  status: true,
  user_id: 4
}

Repo.insert! %Clock{
  time: DateTime.truncate(DateTime.utc_now(), :second),
  status: true,
  user_id: 5
}

Repo.insert! %Clock{
  time: DateTime.truncate(DateTime.utc_now(), :second),
  status: true,
  user_id: 6
}

Repo.insert! %Clock{
  time: DateTime.truncate(DateTime.utc_now(), :second),
  status: true,
  user_id: 7
}
