defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(complete_date, local_origin, local_destination, user_id) do
    id = UUID.uuid4()

    {:ok,
     %__MODULE__{
       id: id,
       complete_date: complete_date,
       local_origin: local_origin,
       local_destination: local_destination,
       user_id: user_id
     }}
  end

  def build(_local_origin, _local_destination, _user_id) do
    {:error, "invalid parameters"}
  end
end
