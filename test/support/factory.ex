defmodule TooShort.Factory do
  @moduledoc """
  Used with ex_machina to create test data.
  """

  use ExMachina.Ecto, repo: TooShort.Repo

  def link_factory do
    %TooShort.Link{
      short_code: "#{Faker.Lorem.characters(6)}",
      url: Faker.Internet.url()
    }
  end
end
