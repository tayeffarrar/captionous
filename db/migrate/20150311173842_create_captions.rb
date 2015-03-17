class CreateCaptions < ActiveRecord::Migration
  def change
    create_table :captions do |t|

      t.timestamps null: false
    end
  end
end
