class PostsController < ApplicationController
  # include ActionView::Helpers::SanitizeHelper
  require 'uri'
  require 'net/http'
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    # byebug
    # uri = URI('http://localhost:3000/requisitions')
    uri = URI('http://localhost:3000/sign_standards?layout=popup')
    res = Net::HTTP.get_response(uri)
    # byebugc
    puts res.body if res.is_a?(Net::HTTPSuccess)
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    # byebug
  end

  # GET /posts/new
  def new
    # byebug
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @user = User.where(id: 'is not null').first
  end

  # POST /posts or /posts.json
  def create
    byebug
    @post = Post.new(post_params)
    @post.user = User.first

    respond_to do |format|
      if @post.save
        render :new and return
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    # byebug
    # @post.body = sanitize(post_params['body'])
    # @post.title = sanitize(post_params['title'])
    respond_to do |format|
      if @post.update(post_params)
      # if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
