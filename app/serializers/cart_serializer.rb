class CartSerializer < Panko::Serializer
  attributes :id, :item_id, :user_id, :item_count
end