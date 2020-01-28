class SearchController < ApplicationController
 before_action :authenticate_user!
 def search
 	# @user = User.find(params[:id])
 	# @book = Book.new
 	@divide_model = params[:search_divide_model]
 	divide_method = params[:search_method]
 	word = params[:search_word]
 	if @divide_model == "1"
	 @books = Book.search(divide_method,word)
	else
	 @users = User.search(divide_method,word)
	end
 end

 private
 	def book_params
 		params.require(:book).permit(:title)
 	end

 	def user_params
 		params.require(:user).permit(:name)
 	end

end
