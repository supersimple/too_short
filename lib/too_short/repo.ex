defmodule TooShort.Repo do
  use Ecto.Repo,
    otp_app: :too_short,
    adapter: Ecto.Adapters.Postgres
end
