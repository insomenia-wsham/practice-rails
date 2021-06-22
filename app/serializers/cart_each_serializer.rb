class CartEachSerializer < Panko::Serializer
  attributes :id, :item_id, :user_id, :item_count
  
  has_one :item, serializer: ItemSerializer
end