defmodule TooShort.Links do
  @moduledoc """
  Queries for a Link record in the data store.
  """
  import Ecto.Query
  alias TooShort.{Link, Repo}

  @doc """
  Queries data store for a record with the given short_code.
  """
  def get_by_short_code(short_code) do
    Repo.get_by(Link, short_code: short_code)
  end

  @doc """
  Gets a list of the most recent links created
  """
  def get_recent(limit \\ 10) do
    Repo.all(from l in Link, order_by: [desc: l.inserted_at], limit: ^limit)
  end

  @doc """
  Creates a new Link.
  """
  def create(attrs) do
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end
end
