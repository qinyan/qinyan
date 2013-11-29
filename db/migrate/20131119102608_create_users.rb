class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :gender
      t.string :logo
      t.string :email
      t.string :password
      t.timestamps
    end
  end
end
