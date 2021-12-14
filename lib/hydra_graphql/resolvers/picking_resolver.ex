defmodule HydraGraphql.Resolvers.PickingResolver do
  alias Hydra.Pickings

  def create_picking(_parent, params, _resolution) do
    Task.async(fn -> Pickings.create_picking(params) end)
    {:ok, "Payload received, all orders are being created!"}
  end
end
