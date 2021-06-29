class OrdersController < ApiController
  def index
    orders = current_api_user.orders.order(created_at: :desc)
    render json: {
      orders: each_serialize(orders),
    }
  end

  def create
    new_order = Order.create(order_params)
    params.dig(:order, :item_list).each do|t|
      OrderDetail.create(order_id: new_order[:id], item_id: t[:item_id], item_count: t[:item_count], order_price: t[:item][:sale_price])
    end
    if !params.dig(:order, :direct)
      current_api_user.carts.destroy_all
    end
    render json: {
      message: '성공적으로 주문하였습니다.',
    }
  end

  private

  # def order_params
  #   params.require(:order).permit(:user_id, :receiver_zipcode, :receiver_address, :receiver_address_detail, :receiver_name, order_details_attributes: [:item_id, :item_count, :order_price])
  # end     accepts_nested_attributes_for 활용하기 bundle show gemFileName

  def order_params
    params.require(:order).permit(:user_id, :receiver_zipcode, :receiver_address, :receiver_address_detail, :receiver_name)
  end
end
