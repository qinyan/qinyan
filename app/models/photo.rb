class Photo < ActiveRecord::Base

  mount_uploader :avatar, PhotoAvatarUploader
  include Rails.application.routes.url_helpers
  
  belongs_to :album

  def to_json_picture
    {
     'name' => read_attribute(:avatar),
     'size' => avatar.size,
     'url'  => avatar.url(:originals),
     'thumbnail_url' => avatar.url(:feed),
     'delete_url' => album_photo_path(self.album_id, self.id),
     'delete_type' => 'DELETE'
    }
  end

end
