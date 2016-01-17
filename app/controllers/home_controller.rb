class HomeController < ApplicationController
	before_filter :authenticate_user!, :except => [:index]
  def index
		if user_signed_in?
			@user = User.find(current_user.id)
		end
  end
end
