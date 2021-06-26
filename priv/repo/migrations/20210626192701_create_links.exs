defmodule TooShort.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :short_code, :string
    end

    create unique_index(:links, [:short_code])
  end
end
