alias TimeManager.Repo
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
