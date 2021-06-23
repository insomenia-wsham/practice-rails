class ReviewsController < ApiController
  def index
		reviews = Review.where(item_id: params[:item_id])
    render json: {
      reviews: each_serialize(reviews),
      total_count: reviews.count,
    }
  end

	def create
		Review.create(params.require(:review).permit(:user_id, :item_id, :content))
		render json: {
			code: 0,
			message: '성공적으로 댓글을 등록하였습니다.'
		}
	end
end
