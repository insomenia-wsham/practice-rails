class OrdersController < ApiController
  def index
    orders = current_api_user.orders.order(created_at: :desc)
    render json: {
      orders: each_serialize(orders),
    }
  end

  def create
    new_order = Order.create(order_params)
    if !params.dig(:order, :direct)
      current_api_user.carts.destroy_all
    end
    render json: {
      message: '성공적으로 주문하였습니다.',
    }
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :receiver_zipcode, :receiver_address, :receiver_address_detail, :receiver_name, order_details_attributes: [:item_id, :item_count, :order_price])
  end
end
