class BookCommentsController < ApplicationController
def create
	@book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
    	# redirect_back(fallback_location: book_path(book))
    end
end

def destroy
	@book = Book.find(params[:book_id])
	@book_comment = @book.book_comments.find(params[:id])
	if @book_comment.destroy
		# redirect_back(fallback_location: book_path(book))
	end
end

private
def book_comment_params
    params.require(:book_comment).permit(:user_id,:book_id,:comment)
end
end
