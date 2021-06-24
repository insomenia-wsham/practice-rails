class ReviewsController < ApiController
  def index
    reviews = Review.where(item_id: params[:item_id])
    render json: {
      reviews: each_serialize(reviews),
      total_count: reviews.count,
    }
  end

  def create
    Review.create(user_id: current_api_user.id, item_id: params[:item_id], content: review_params[:content])
    render json: {
      message: '성공적으로 댓글을 등록하였습니다.'
    }
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
