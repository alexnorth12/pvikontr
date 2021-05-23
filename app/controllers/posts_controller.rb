class PostsController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]

    def index
        @q = Post.ransack(params[:q])
        @posts = @q.result.paginate(page: params[:page], per_page: 3)
    end

    def new
        @post = Post.new
    end

    def show
        @post = Post.find(params[:id])
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])

        if(@post.update(post_params))
            redirect_to @post, success: 'Post was succesfully updated '
        else
            render 'edit', danger: 'Post was not updated' 
        end 
    end

    def destroy
        @post = Post.find(params[:id])

        @post.destroy
        redirect_to posts_path, success: 'Post was succesfully deleted' 
    end 

    def create
        @post = Post.new(post_params)

        if(@post.save)
            redirect_to @post, success: 'Post was succesfully created'
        else
            render 'new'
        end  
    end

    private def post_params
        params.require(:post).permit(:title, :body, :tags, :image)
    end
end
