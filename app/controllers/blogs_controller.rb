class BlogsController < ApplicationController

  before_filter :load_blog, only: [:show, :update, :edit, :destroy]
  skip_before_filter :require_login, only: [:index, :show]
  before_filter :check_blog_user, only: [:edit, :update, :destroy]

  def index
    @blogs = Blog.paginate page: params[:page]||1, per_page: 10
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = @current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to blogs_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @blog.update_attributes(blog_params)
      redirect_to blogs_path
    else
      render :edit
    end
  end

  def destroy
    redirect_to blogs_path if @blog.destroy
  end

  private

  def load_blog
    @blog = Blog.find(params[:id])
  end

  def check_blog_user
    redirect_to blogs_path unless @current_user.present?
    redirect_to blog_path(@blog) unless @blog.user_id.eql?(@current_user.id)
  end
  
  def blog_params
    params.require(:blog).permit(:name, :intro, :content)
  end
   
end
