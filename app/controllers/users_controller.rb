class UsersController < ApiController
  def update
    user = User.find(current_api_user.id)
    user.update(name: user_params[:name]) 
    render json: serialize(user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
