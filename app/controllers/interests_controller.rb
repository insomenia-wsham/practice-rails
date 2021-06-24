class InterestsController < ApiController
  def index
    interests = current_api_user.interests.order(:created_at)
    render json: {
      interests: each_serialize(interests),
      total_count: interests.count
    }
  end

  def create
    item_check = current_api_user.interests.find_or_initialize_by(item_id: interest_params[:item_id])
    
    if item_check.new_record?
      item_check.save()
      success = true
    end

    render json: {
      success: success
    }
  end

  def destroy
    interest = load_interests.destroy()

    render json: serialize(interest)
  end
  
  private

  def interest_params
    params.require(:interest).permit(:item_id)
  end

  def load_interests
    current_api_user.interests.find(params[:id])
  end
end
