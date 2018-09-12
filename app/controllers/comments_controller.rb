class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_params)

      if @comment.save

        render json: { status: :ok, comment: @comment.as_json }
      else
        render json: { errors: @comment.errors, status: :unprocessable_entity }
      end
  end

  def comment_params
      params.require(:comment).permit(:body, :post_id)
  end

end
