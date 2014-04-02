class PhotosController < ApplicationController

  before_filter :load_album
  skip_before_filter :require_login, only: [:show]

  def new 
  end

  def create
    photo = Photo.new(params.require(:photo).permit(:avatar))
    photo.name = params[:photo][:avatar].original_filename
    photo.album_id = @album.id
    respond_to do |format|  
      if photo.save  
        format.html {  
          render :json => [photo.to_json_picture].to_json,  
          :content_type => 'text/html',  
          :layout => false  
        }  
        format.json { render json: {files: [photo.to_json_picture]}, status: :created, location: album_photo_url(@album.id, photo.id) }  
      else  
        format.html { render action: "new" }  
        format.json { render json: photo.errors, status: :unprocessable_entity }  
      end  
    end 
  end

  def destroy  
    @photo = Photo.find(params[:id])  
    @photo.destroy  
    respond_to do |format|  
      format.html { redirect_to album_photos_url(@album.id) }  
      format.json { head :no_content }  
    end  
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def set_cover
    @photo = Photo.find(params[:id])
    @album.update_attributes(cover_path: @photo.avatar_url(:medium))
    redirect_to album_photo_path(@album.id, @photo.id)
  end

  private
  def photo_params
  end
  
  def load_album
    @album = Album.find(params[:album_id])
  end
end
