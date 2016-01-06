class BooksController < ApplicationController
	before_action :set_user
	before_action :set_book, :only => [:show, :edit, :update, :destroy]

	def index
		@books = @user.books.all
	end

	def show
	end

	def new
		@book = @user.books.new
	end

	def edit
	end

	def create
		@book = @user.books.new(book_params)
		if @book.save
			redirect_to([@user,@book], :notice => 'Book was successfully created.')
		else
			render :action => "new"
		end
	end

	def update
		if @book.update_attributes(book_params)
			redirect_to([@user, @book], :notice => 'Book was successfully updated.')
		else
			render :action => "edit"
		end
	end

	def destroy
		@book.destroy
		redirect_to([@user, @book])
	end

	def get_info
		Amazon::Ecs.debug = true
		@res = Amazon::Ecs.item_search(
			params[:isbn],
			:search_index => 'Books',
			:response_group => 'Medium',
			:country => 'jp'
		)
		info = {
			'Title' => @res.first_item.get("ItemAttributes/Title"),
			'Author' => @res.first_item.get("ItemAttributes/Author"),
			'Manufacturer' => @res.first_item.get("ItemAttributes/Manufacturer"),
			'ImageURL' => @res.first_item.get("LargeImage/URL"),
		}
		render json: info
	end

	private
	def book_params
		params[:book].permit(:isbn, :title, :author, :manufacturer, :user_id)
	end
	def set_user
		@user = User.find(params[:user_id])
	end

	def set_book
		@book = @user.books.find(params[:id])
	end

end
