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
		#Amazon::Ecs.configure do |options|
		#	options[:AWS_access_key_id] = 'AKIAIKXBBHGAW7VXE3OQ'
		#	options[:AWS_secret_key] = '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'
		#	options[:associate_tag] = 'kamekame0c-22'
		#end

		Amazon::Ecs.debug = true
		@res = Amazon::Ecs.item_search(
			params[:isbn],
			:search_index => 'Books',
			:response_group => 'Medium',
			:country => 'jp'
		)
	end

	private
	def book_params
		params[:book].permit(:isbn, :title, :user_id)
	end
	def set_user
		@user = User.find(params[:user_id])
	end

	def set_book
		@book = @user.books.find(params[:id])
	end

end
