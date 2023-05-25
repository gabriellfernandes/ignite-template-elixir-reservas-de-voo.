defmodule Flightex do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.Agent, as: BookingAgent

  def start_agent() do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end
end
