class InterestEachSerializer < Panko::Serializer
  attributes :id, :user_id, :item_id, :created_at, :updated_at 

  has_one :item, serializer: ItemSerializer
end