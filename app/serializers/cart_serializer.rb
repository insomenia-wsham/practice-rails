class CartSerializer < Panko::Serializer
  attributes :id, :item_id, :item_count
end