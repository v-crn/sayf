class AddReferenceIdToSayings < ActiveRecord::Migration[5.2]
  def change
    add_column :sayings, :reference_id, :integer
  end
end
