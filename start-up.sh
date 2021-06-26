#!/bin/sh
mix ecto.create
echo "Database $DATABASE_NAME exists, running migrations..."
mix ecto.migrate
echo "Migrations finished."

exec mix phx.server