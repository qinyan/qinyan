class AjaxController < ApplicationController

  def new_album
    @album = @current_user.albums.build(name: params[:album_name])
    if @album.save
      render text: {message: '创建成功', success: true}.to_json 
    else
      render text: {message: @album.errors[:name].join(','), success: false}.to_json
    end
  end
end