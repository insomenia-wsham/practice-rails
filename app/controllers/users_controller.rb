class UsersController < ApiController
  def update
    user = current_api_user
    user.update(user_params)
    render json: serialize(user)
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
