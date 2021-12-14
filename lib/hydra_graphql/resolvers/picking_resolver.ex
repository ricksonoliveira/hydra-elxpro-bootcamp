defmodule HydraGraphql.Resolvers.PickingResolver do

  def create_picking(_parent, params, _resolution) do
    # IO.inspect params
    {:ok, "Payload received, all orders are being created!"}
  end
end
