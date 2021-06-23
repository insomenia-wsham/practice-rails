class CartsController < ApiController

  def index
		carts = current_api_user.carts
    render json: {
      carts: each_serialize(carts),
      total_count: carts.count,
    }
  end

	def create
		itemCart = current_api_user.carts.where(item_id: params['cart']['item_id'])
		if itemCart.count > 0
			message = '이미 장바구니에 담겨있는 상품입니다.'
		else
			message = '장바구니에 성공적으로 담겼습니다.'
			Cart.create(params.require(:cart).permit(:user_id, :item_id, :item_count))
		end
		render json: {
			code: 0,
			message: message
		}
	end

	def update
		current_api_user.carts.where(id: params['cart']['id']).update(params.require(:cart).permit(:item_count))

		render json: {
			code: 0,
			message: '성공적으로 수정하였습니다.'
		}
	end

	def destroy
		current_api_user.carts.destroy(params[:id])

		render json: {
			code: 0,
			message: '성공적으로 삭제하였습니다.'
		}
	end

end
