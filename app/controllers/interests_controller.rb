class InterestsController < ApiController

  def index
		interests = current_api_user.interests
    render json: {
      interests: each_serialize(interests),
      total_count: interests.count
    }
  end

	def create
		itemInterest = current_api_user.interests.where(item_id: params['interest']['item_id'])
		if itemInterest.count > 0
			message = '이미 관심목록에 있는 상품입니다.'
		else
			message = '관심목록에 성공적으로 추가했습니다.'
			Interest.create(params.require(:interest).permit(:user_id, :item_id))
		end
		render json: {
			code: 0,
			message: message
		}
	end

	def destroy
		current_api_user.interests.destroy(params[:id])

		render json: {
			code: 0,
			message: '성공적으로 삭제하였습니다.'
		}
	end

end
