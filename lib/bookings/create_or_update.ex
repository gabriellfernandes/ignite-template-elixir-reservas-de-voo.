defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  def call(%{
        complete_date: complete_date,
        local_destination: local_destination,
        local_origin: local_origin,
        user_id: user_id
      }) do
    users =
      UserAgent.get_all()
      |> Map.values()

    case Enum.find(users, fn %{id: id} -> id == user_id end) do
      nil ->
        {:error, "user id invalid"}

      user ->
        Booking.build(complete_date, local_origin, local_destination, user.id)
        |> save_booking()
    end
  end

  defp save_booking({:ok, booking}) do
    BookingAgent.save(booking)
  end

  defp save_booking({:error, _reason} = error), do: error
end
