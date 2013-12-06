class PhotosController < ApplicationController

  before_filter :load_album

  def index
    @photos = @album.photos.paginate(page: params[:page]||1, per_page: 2)
  end

  def new 
  end

  def create
    photo = Photo.new(params.require(:photo).permit(:avatar))
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

  private
  def photo_params
  end
  
  def load_album
    @album = Album.find(params[:album_id])
  end
end
