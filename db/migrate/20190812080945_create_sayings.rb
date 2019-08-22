

class CreateSayings < ActiveRecord::Migration[5.2]
  def change
    create_table :sayings do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :sayings, %i[user_id created_at]
  end
end
