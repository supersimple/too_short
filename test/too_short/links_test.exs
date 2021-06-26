defmodule TooSHort.LinksTest do
  use TooShort.DataCase

  alias TooShort.Links

  describe "get_by_short_code/1" do
    test "when the record does not exist" do
      assert Links.get_by_short_code("doesnotexist") == nil
    end

    test "when the record exists" do
      link = insert(:link)
      %{url: url, short_code: short_code} = Links.get_by_short_code(link.short_code)
      assert url == link.url
      assert short_code == link.short_code
    end
  end

  describe "create/1" do
    test "when given required attributes" do
      link_attrs = params_for(:link)
      assert {:ok, link} = Links.create(link_attrs)
      assert link.id
    end

    test "when given invalid params" do
      assert {:error, _error} = Links.create(%{})
    end

    test "when given a duplicated short_code" do
      existing_link = insert(:link)

      assert {:error, changeset} =
               Links.create(%{url: existing_link.url, short_code: existing_link.short_code})

      assert changeset.errors == [
               short_code:
                 {"has already been taken",
                  [constraint: :unique, constraint_name: "links_short_code_index"]}
             ]
    end
  end
end
