defmodule TooShort.Repo.Migrations.AddTimestampsToLinks do
  use Ecto.Migration

  def change do
    alter table(:links) do
      timestamps(type: :utc_datetime_usec, updated_at: false)
    end
  end
end
