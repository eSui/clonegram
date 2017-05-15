class PostsController < ApplicationController
before_action :set_post, only: [:show, :update, :edit, :destroy]

def index
 @posts = Post.all
end

def new
  @post = Post.new
end

def show
end

def edit
end

def create
  if @post = Post.create(post_params)
    flash[:success] = "Your post has been created!"
    redirect_to posts_path
  else
    flash[:alert] = "Post could not be created. Please check the form"
    render :new
  end
end

def update
  if @post.update(post_params)
    flash[:success] = "Your post has been updated"
    redirect_to post_path
  else
    flash[:alert] = "Update Failed. Please check form"
    render :edit
  end
end

def destroy
  @post.destroy
  redirects_to posts_path
end

private

def post_params
  params.require(:post).permit(:image, :caption)
end

def set_post
  @post = Post.find(params[:id])
end

end
