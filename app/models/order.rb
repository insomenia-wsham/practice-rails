class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_details, dependent: :destroy #주문이 삭제가 되면, 해당 주문상세도 전체 삭제

  # accepts_nested_attributes_for :order_details
end
