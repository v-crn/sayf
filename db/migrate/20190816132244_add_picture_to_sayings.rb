class AddPictureToSayings < ActiveRecord::Migration[5.2]
  def change
    add_column :sayings, :picture, :string
  end
end
