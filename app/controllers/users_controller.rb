class UsersController < ApplicationController

  def show
		@user = User.find(params[:id])
		@books = @user.books.all
  end

	def search
		if params[:username] != ""
		@user = User.find(current_user.id)
		@users = User.where("username like ?", "%#{params[:username]}%")
			render :template => "home/index"
		else
			redirect_to(home_index_path, :alert => "Input username you want to search into textbox")
		end
	end

end
