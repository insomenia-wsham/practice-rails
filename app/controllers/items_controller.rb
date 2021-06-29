class ItemsController < ApiController
  def index
    items = item_result.limit(params[:limit]).offset(params[:offset])
    render json: {
      items: each_serialize(items),
      total_count: item_result.count
    }
  end

  def show
    item = Item.find(params[:id])
    render json: serialize(item)
  end

  private

  def index_params
    params.fetch(:q, {}).permit(:s, :category_id_eq)
  end

  def item_result
    Item.ransack(index_params).result
  end
end
