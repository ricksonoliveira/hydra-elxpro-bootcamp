defmodule Hydra.Pickings.Core.StorePickings do
  alias Hydra.Repo
  alias Hydra.Stores.Store
  def store_pickings_into_mongo(%{"products" => products}) do
    products
    |> build_payload_per_product()
    |> insert_into_mongo
    |> IO.inspect
  end

  defp build_payload_per_product(products) do
    products
    |> Enum.map(&build_payload_to_insert_into_mongo_per_store(&1["stores"], &1["product"]))
    |> List.flatten()
  end

  defp build_payload_to_insert_into_mongo_per_store(stores, product_name) do
    stores
    |> Enum.map(fn store_id ->
      store = Repo.get(Store, store_id)
        %{
          store: %{
          id: store.id,
          descrtiption: store.description,
          name: store.name,
          email: store.email,
          lat: store.lat,
          lng: store.lng
        },
        product: product_name,
        delivered: false
      }
    end)
  end

  defp insert_into_mongo(products) do
    Enum.map(products, &perform_insert/1) |> IO.inspect
  end

  defp perform_insert(product) do
    {:ok, response} = Mongo.insert_one(:mongo, "orders", product)
    response
  end
end

# payload = %{
#   "products" => [
#     %{
#       "product" => "Luke",
#       "stores" => ["31f34ed7-8469-45bb-9fb1-f60519f8fb8f",
#        "dc8095c3-85a9-4ce1-8d0d-2e16abd12477"]
#     },
#     %{
#       "product" => "Han",
#       "stores" => ["31f34ed7-8469-45bb-9fb1-f60519f8fb8f",
#        "dc8095c3-85a9-4ce1-8d0d-2e16abd12477"]
#     }
#   ]
# }
