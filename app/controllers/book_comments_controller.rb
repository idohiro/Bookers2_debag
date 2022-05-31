class BookCommentsController < ApplicationController
   before_action :authenticate_user!
   def create
    @comment = BookComment.new(comment_params)
    if @comment.save
      redirect_to book_path(@comment.book)
    else
      @book = @comment.book
      render "books/show"
    end
   end

  def destroy
    @comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    @comment.destroy
    redirect_to book_path(@comment.book)
  end

  private
  def comment_params
    params.require(:book_comment).permit(:text).merge(user_id: current_user.id, book_id: params[:book_id])
  end
end
