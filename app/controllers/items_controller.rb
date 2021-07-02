class ItemsController < ApiController
  def index
    items = item_result
    render json: {
      items: each_serialize(items.limit(params[:limit]).offset(params[:offset])),
      total_count: items.size
    }
  end

  def show
    item = Item.find(params[:id])
    render json: serialize(item)
  end

  private

  def index_params
    params.fetch(:q, {}).permit(:s, :category_id_eq, :name_cont)
  end

  def item_result
    Item.ransack(index_params).result
  end
end
