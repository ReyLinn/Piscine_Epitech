alias TimeManager.Repo
alias TimeManager.Accounts.User
alias TimeManager.Accounts.Team
#Admin
Repo.insert! %User{
  username: "ADMIN",
  email: "admin@admin.com",
  role_id: 1,
  team_id: nil
}
Repo.insert! %Team{
  manager_id: 1
}

#General Manager
Repo.insert! %User{
  username: "username1",
  email: "email1@email.com",
  role_id: 2,
  team_id: nil
}
Repo.insert! %Team{
  manager_id: 2
}

#Managers
Repo.insert! %User{
  username: "username2",
  email: "email2@email.com",
  role_id: 3,
  team_id: 2
}
Repo.insert! %Team{
  manager_id: 3
}

Repo.insert! %User{
  username: "username3",
  email: "email3@email.com",
  role_id: 3,
  team_id: 2
}
Repo.insert! %Team{
  manager_id: 4
}

#Users of Team of Manager1
Repo.insert! %User{
  username: "username4",
  email: "email4@email.com",
  role_id: 4,
  team_id: 3
}

Repo.insert! %User{
  username: "username5",
  email: "email5@email.com",
  role_id: 4,
  team_id: 3
}
#Users of Team of Manager2
Repo.insert! %User{
  username: "username6",
  email: "email6@email.com",
  role_id: 4,
  team_id: 4
}

Repo.insert! %User{
  username: "username7",
  email: "email7@email.com",
  role_id: 4,
  team_id: 4
}
