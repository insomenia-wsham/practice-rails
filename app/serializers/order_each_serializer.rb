class OrderEachSerializer < Panko::Serializer
  attributes :id, :receiver_zipcode, :receiver_address, :receiver_address_detail, :receiver_name, :created_at, :updated_at

  has_many :order_details, each_serialize: OrderDetailSerializer
end