class ReviewEachSerializer < Panko::Serializer
  attributes :id, :item_id, :content, :created_at, :updated_at

  has_one :user, serializer: UserSerializer
end