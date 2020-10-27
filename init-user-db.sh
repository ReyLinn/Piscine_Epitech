set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE timemanager_database
    GRANT ALL PRIVILEGES ON DATABASE timemanager_database TO postgres;
EOSQL