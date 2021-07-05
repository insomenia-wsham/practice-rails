class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_details, dependent: :destroy

  accepts_nested_attributes_for :order_details
end
