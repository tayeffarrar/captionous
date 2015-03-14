class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
    	t.integer :picture_id
    	t.integer :contributor_id

      t.timestamps null: false
    end
  end
end
