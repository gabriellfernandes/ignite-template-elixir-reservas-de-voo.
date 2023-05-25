defmodule Flightex.Users.Agent do
  use Agent
  alias Flightex.Users.User

  def start_link(_init) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{id: id} = user) do
    Agent.update(__MODULE__, &update_user(&1, user))

    {:ok, id}
  end

  def get_all(), do: Agent.get(__MODULE__, & &1)

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp get_user(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_user(state, %User{cpf: cpf} = user), do: Map.put(state, cpf, user)
end
