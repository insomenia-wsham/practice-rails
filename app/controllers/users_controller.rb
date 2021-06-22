class UsersController < ApiController
	def index
		user = User.all
		render json: each_serialize(user)
	end

	def show
		user = User.find(params[:id])
		render json: serialize(user)
	end

	def update
		user = User.find(params[:id])
		user.update(params.require(:user).permit(:name))
		render json: serialize(user)
	end

	def destroy
	end

end
