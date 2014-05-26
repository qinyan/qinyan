class AlbumsController < ApplicationController

  skip_before_filter :require_login, only: [:index, :show]


  def new
    @album = @current_user.albums.build
  end

  def create
    @album = @current_user.albums.build(album_params)
    if @album.save
      redirect_to albums_path
    else
      render :new
    end
  end

  def index
    @albums = Album.paginate page: params[:page]||1, per_page: 12
  end
 
  def show
    @album = Album.find(params[:id])
    @photos = @album.photos.paginate(page: params[:page]||1, per_page: 12)
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_path(params[:id])
    else
      render :edit
     end
  end

  def destroy
    @album = Album.find(params[:id])
    redirect_to albums_path if @album.destroy
  end

  private
  def album_params
    params.require(:album).permit(:name)
  end
end
