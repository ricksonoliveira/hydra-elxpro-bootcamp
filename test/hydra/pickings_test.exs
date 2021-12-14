defmodule Hydra.PickingsTest do
  use Hydra.DataCase
  alias Hydra.Pickings
  alias Hydra.Pickings.Core.SendProductsToKafka
  import Mock

  test "should create pickings" do
    products = %{
      products: [
        %{product: "123", stores: ["123", "123123"]},
        %{product: "123", stores: ["123", "123123"]}
      ]
    }

    with_mock(SendProductsToKafka, [
      start_client: fn _hosts, _client_id, _opts -> :ok end,
      start_producer: fn _client_id, _topic, _opts -> :ok end,
      produce: fn _client_id, _topic, _partition, _key, _payload -> {:ok, {:brod_call_red, 123, 123, "abc"}} end
    ])

    assert Pickings.create_picking(products) == {:ok, {:brod_call_red, 123, 123, "abc"}}
  end

end
