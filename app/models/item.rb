class Item < ApplicationRecord
  include ImageUrl
  include Imagable
  belongs_to :user, optional: true
  belongs_to :category
  paginates_per 10
  enum status: { active: 0, disabled: 1 }

  has_many :carts, dependent: :destroy #상품이 삭제가 될 때, 해당 장바구니도 전체 삭제
  has_many :reviews, dependent: :destroy #상품이 삭제가 될 때, 해당 리뷰들도 전체 삭제
  has_many :interests, dependent: :destroy #상품이 삭제가 될 때, 해당 관심들도 전체 삭제
  has_many :interested_users, through: :interests, source: :user #임의로 정한 interested_users로 user 테이블로부터 interests를 가져옴
  has_many :order_details, dependent: :nullify
end
