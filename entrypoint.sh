# entrypoint.sh

#!/bin/bash
# Docker entrypoint script.

# Wait until Postgres is ready
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE timemanager_database
    GRANT ALL PRIVILEGES ON DATABASE timemanager_database TO postgres;
EOSQL


# Create, migrate, and seed database if it doesn't exist.

exec mix ecto.migrate
exec mix run priv/repo/seeds/roles_seeds.exs
exec mix run priv/repo/seeds/users_seeds.exs
exec mix run priv/repo/seeds/clocks_seeds.exs
exec mix run priv/repo/seeds/workingtimes_seeds.exs
exec mix phx.server