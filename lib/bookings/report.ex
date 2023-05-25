defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(file_name \\ "report.csv") do
    order_list = BookingAgent.get_all()
    |> Map.values()
    |> list_bookings()

    File.write!(file_name, order_list)
  end

  defp list_bookings(bookings) do
    Enum.map(bookings, &convert_to_string/1)
  end

  defp convert_to_string(%Booking{
         user_id: user_id,
         complete_date: complete_date,
         local_destination: local_destination,
         local_origin: local_origin
       }) do
    date =
      complete_date
      |> NaiveDateTime.to_string()

    "#{user_id},#{local_origin},#{local_destination},#{date}\n"
  end
end
