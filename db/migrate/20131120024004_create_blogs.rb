class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer  :user_id
      t.string   :name
      t.string   :intro
      t.text     :content
      t.timestamps
    end
  end
end
