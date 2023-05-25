defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case, async: false
  import Flightex.Factory
  alias Flightex.Bookings.{Agent, CreateOrUpdate}
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when all params are valid, returns a valid tuple" do
      params = %{
        complete_date: ~N[2001-05-07 03:05:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "e9f7d281-b9f2-467f-9b34-1b284ed58f9e"
      }

      :users
      |> build(id: "e9f7d281-b9f2-467f-9b34-1b284ed58f9e")
      |> UserAgent.save()

      {:ok, uuid} = CreateOrUpdate.call(params)

      {:ok, response} = Agent.get(uuid)

      expected_response = %Flightex.Bookings.Booking{
        id: response.id,
        complete_date: ~N[2001-05-07 03:05:00],
        local_destination: "Bananeiras",
        local_origin: "Brasilia",
        user_id: "e9f7d281-b9f2-467f-9b34-1b284ed58f9e"
      }

      assert response == expected_response
    end
  end
end
