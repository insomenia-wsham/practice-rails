class ReviewSerializer < Panko::Serializer
  attributes :id, :item_id, :user_id, :content, :created_at, :updated_at 
end