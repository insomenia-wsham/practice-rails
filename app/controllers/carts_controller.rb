class CartsController < ApiController
  before_action :load_cart, only: [:destroy]

  def index
    carts = current_api_user.carts.order(:created_at)

    render json: {
      carts: each_serialize(carts),
      total_count: carts.count,
    }
  end

  def create

    cart = current_api_user.carts.find_or_initialize_by(item_id: cart_params[:item_id])

    if cart.new_record?
      cart.item_count = cart_params[:item_count]
      cart.save()
      success = true
    end
    
    render json: {
      success: success
    }
  end

  def update
    cart = current_api_user.carts.find(params[:id])
    load_cart.update(item_count: cart_params[:item_count])

    render json: serialize(cart)
  end

  def destroy
    cart = load_cart.destroy()

    render json: serialize(cart)
  end

  private

  def cart_params
    params.require(:cart).permit(:item_id, :item_count)
  end

  def load_cart
    current_api_user.carts.find(params[:id])
  end
end

