class ReviewsController < ApiController
  def index
    reviews = Review.where(item_id: params[:item_id]).order(created_at: :desc)
    render json: {
      reviews: each_serialize(reviews),
      total_count: reviews.count,
    }
  end

  def create
    review = Review.create(user_id: current_api_user.id, item_id: params[:item_id], content: review_params[:content])
    render json: serialize(review)
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy()

    render json: serialize(review)
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
