class OrdersController < ApiController

  def index
		orders = current_api_user.orders.order( 'id DESC' )
    render json: {
      orders: each_serialize(orders),
    }
  end

	def create
		newOrder = Order.create(params.require(:order).permit(:user_id, :receiver_zipcode, :receiver_address, :receiver_address_detail, :receiver_name))
		params["order"]["item_list"].each do|t|
			OrderDetail.create(order_id: newOrder[:id], item_id: t[:item_id], item_count: t[:item_count], order_price: t[:item][:sale_price])
		end
		current_api_user.carts.destroy_all
		render json: {
			code: 0,
			message: '성공적으로 주문하였습니다.',
		}
	end

end
