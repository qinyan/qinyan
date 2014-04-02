class AddAlbumsCover < ActiveRecord::Migration
  def change
    add_column :albums, :cover_path, :string
  end
end
