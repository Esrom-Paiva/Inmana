defmodule InmanaWeb.RestaurantsControllerTest do
  use InmanaWeb.ConnCase, async: true

  describe("create/2") do
    test "when all are valid params, creates the user", %{conn: conn} do
      params = %{name: "Restaurant Test", email: "Restaurant@Test.com"}

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "Restaurant created!",
               "restaurant" => %{
                 "email" => "Restaurant@Test.com",
                 "id" => _id,
                 "name" => "Restaurant Test"
               }
             } = response
    end

    test "when all are invalid params, returns an error", %{conn: conn} do
      params = %{email: "Restaurant@Test.com"}

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => %{"name" => ["can't be blank"]}}

      assert response == expected_response
    end
  end
end
