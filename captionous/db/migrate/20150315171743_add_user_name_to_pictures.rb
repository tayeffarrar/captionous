class AddUserNameToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :contributor, :string
  end
end
