# entrypoint.sh

#!/bin/bash
# Docker entrypoint script.

# Wait until Postgres is ready
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.

exec mix ecto.migrate
exec mix run priv/repo/seeds/roles_seeds.exs
exec mix run priv/repo/seeds/users_seeds.exs
exec mix run priv/repo/seeds/clocks_seeds.exs
exec mix run priv/repo/seeds/workingtimes_seeds.exs
exec mix phx.server