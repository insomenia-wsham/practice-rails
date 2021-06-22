class User < ApplicationRecord
  paginates_per 8
  include ImageUrl
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :items, dependent: :nullify
  enum gender: { unknown: 0, male: 1, female: 2 }
  
  has_many :orders, dependent: :nullify #사용자가 삭제할 때, 해당 사용자의 주문들의 정보중 사용자id만 nul값으로 변경
  has_many :carts, dependent: :destroy #사용자가 삭제할 때, 해당 사용자의 장바구니도 전체 삭제
  has_many :reviews, dependent: :destroy #사용자가 삭제할 때, 해당 사용자의 리뷰들도 전체 삭제
  has_many :interests, dependent: :destroy #사용자가 삭제할 때, 해당 사용자의 관심도 전체 삭제
  has_many :interested_items, through: :interests, source: :item #임의로 정한 interested_items로 item 테이블로부터 interests를 가져옴
end
