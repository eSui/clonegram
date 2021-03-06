class PostsController < ApplicationController
before_action :set_post, only: [:show, :update, :edit, :destroy]
before_action :authenticate_user!
before_action :owned_post, only: [:edit, :update, :destroy]


def index
 @posts = Post.all.order('created_at DESC').page params[:page]
end

def new
  @post = current_user.posts.build
end

def show
end

def edit
end

def create
  @post = current_user.posts.build(post_params)

  if @post.save
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

def owned_post
  unless current_user ==@post.user
    flash[:alert] = "That is not your post. "
    redirect_to root_path
  end
end

end
