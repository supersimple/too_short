defmodule TooShort.LinkTest do
  use TooShort.DataCase

  alias TooShort.Link

  describe "changeset/2" do
    test "when all attrs are valid" do
      valid_attrs = %{url: "https://bleacherreport.com", short_code: "bL34ch"}
      changeset = Link.changeset(%Link{}, valid_attrs)
      assert changeset.valid?
      assert changeset.changes == valid_attrs
    end

    test "when url attr is missing" do
      invalid_attrs = %{short_code: "bL34ch"}
      changeset = Link.changeset(%Link{}, invalid_attrs)
      refute changeset.valid?
      assert changeset.errors == [url: {"can't be blank", [validation: :required]}]
    end

    test "when short_code attr is missing" do
      invalid_attrs = %{url: "https://bleacherreport.com"}
      changeset = Link.changeset(%Link{}, invalid_attrs)
      refute changeset.valid?
      assert changeset.errors == [short_code: {"can't be blank", [validation: :required]}]
    end

    test "when the url is not a valid format" do
      invalid_attrs = %{url: "bleacherreport.c", short_code: "bL34ch"}
      changeset = Link.changeset(%Link{}, invalid_attrs)
      refute changeset.valid?
      assert changeset.errors == [url: {"expects a url starting with http or https", []}]
    end
  end

  describe "generate_short_code/1" do
    test "will create a short code of 6 chars" do
      short_code = Link.generate_short_code()
      assert String.length(short_code) == 6
    end
  end

  describe "url_valid?/1" do
    test "an empty string is not valid" do
      assert Link.url_valid?("") == false
    end

    test "an http url is valid" do
      assert Link.url_valid?("http://foo.io") == true
    end

    test "an https url is valid" do
      assert Link.url_valid?("https://foo.io") == true
    end

    test "a url with subdomain is valid" do
      assert Link.url_valid?("http://sub.foo.io") == true
    end

    test "a url with path and params is valid" do
      assert Link.url_valid?("http://foo.io/some/path?v=1&p=1") == true
    end

    test "a url with a longer TLD is valid" do
      assert Link.url_valid?("http://foo.engineering/") == true
    end

    test "a url with Chinese characters is valid" do
      assert Link.url_valid?("http://見.香港/") == true
    end
  end
end
