defmodule Inmana.RestaurantTest do
  use Inmana.DataCase, async: true

  alias Ecto.Changeset
  alias Inmana.Restaurant

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Restaurant Test", email: "Restaurant@Test.com"}

      response = Restaurant.changeset(params)

      assert %Changeset{
               changes: %{
                 email: "Restaurant@Test.com",
                 name: "Restaurant Test"
               },
               valid?: true
             } = response
    end

    test "when all are invalid params, returns a invalid changeset" do
      params = %{name: "R", email: ""}

      response = Restaurant.changeset(params)

      expected_response = %{
        email: ["can't be blank"],
        name: ["should be at least 2 character(s)"]
      }

      assert %Changeset{valid?: false} = response

      assert errors_on(response) == expected_response
    end
  end
end
