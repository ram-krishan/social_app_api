class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  #before_action :authenticate_user!

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 3)
    render json: {currentPage: params[:page].to_i, totalPages: @posts.total_pages, perPage: 3, posts: @posts.as_json}
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)
      if @post.save
        render json: { status: :ok, post: @post.as_json(current_user) }
      else
        render json: {errors: @post.errors, status: :unprocessable_entity }
      end
  end

  def like
    unless current_user.likes.where(post: @post).exists?
      if current_user.likes.create(post: @post)
        render json: { status: :ok, post: @post.as_json(current_user) }
      else
        render json: {errors: 'unable to like post', status: :unprocessable_entity }
      end
    else
      current_user.likes.where(post: @post).destroy_all
      render json: { status: :ok, post: @post.as_json(current_user) }
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:image, :body, :user_id)
    end
end
