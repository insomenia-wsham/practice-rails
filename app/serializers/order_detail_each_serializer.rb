class OrderDetailEachSerializer < Panko::Serializer
  attributes :id, :order_id, :item_id, :item_count, :order_price, :created_at, :updated_at

  has_one :item, serializer: ItemSerializer
end