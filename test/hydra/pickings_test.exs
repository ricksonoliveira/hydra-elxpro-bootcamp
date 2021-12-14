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
      execute: fn _products -> {:ok, {:brod_call_red, 123, 123, "abc"}} end,
    ])

    assert Pickings.create_picking(products) == {:ok, {:brod_call_red, 123, 123, "abc"}}
  end

end
