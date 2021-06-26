defmodule TooShort.Link do
  @moduledoc """
  Schema and functionality for a Link.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @short_code_chars ~w[A C D E F H J K L M
                       N P Q R T U V W X Y
                       a b c d e f g h i j
                       k m n o p q r s t u
                       v w x y z 3 4 7 9]
  @short_code_length 6

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "links" do
    field :short_code, :string
    field :url, :string
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :short_code])
    |> validate_required([:url, :short_code])
    |> validate_change(:url, &validate_url/2)
    |> unique_constraint(:short_code)
  end

  @doc """
  Generates a random short code with a length of `@short_code_length`
  using the `@short_code_chars`.
  There is a remote possibility the randomly generated code will be a duplicate.
  *The number of unique codes is length(@short_code_chars)^@short_code_length.
  """

  def generate_short_code do
    Enum.reduce(1..@short_code_length, [], fn _n, acc ->
      acc ++ Enum.take_random(@short_code_chars, 1)
    end)
    |> List.to_string()
  end

  @doc """
  Expects a URL string. Verifies that the given
  binary can be parsed as a %URI{}, and that it
  has a scheme (either http or https), and a host.
  Also verifies the host matches an expected format.
  """
  def url_valid?(url) when is_binary(url) do
    parsed = URI.parse(url)

    not is_nil(parsed.scheme) and
      not is_nil(parsed.host) and
      parsed.scheme in ["http", "https"] and
      String.match?(parsed.host, ~r/.+\..{2,}$/)
  end

  def url_valid?(_url), do: false

  defp validate_url(field, value) do
    if url_valid?(value), do: [], else: [{field, "expects a url starting with http or https"}]
  end
end
