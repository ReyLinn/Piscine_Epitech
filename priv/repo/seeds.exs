alias TimeManager.Repo
alias TimeManager.Accounts
alias TimeManager.Accounts.Role

Repo.insert! %Role{
  name: "Admin"
}

Repo.insert! %Role{
  name: "General Manager"
}

Repo.insert! %Role{
  name: "Manager"
}

Repo.insert! %Role{
  name: "Employee"
}

Accounts.create_user(%{
  username: "ADMIN",
  email: "admin@admin.com",
  password: "admin",
  role_id: 1,
  team_id: nil
})
