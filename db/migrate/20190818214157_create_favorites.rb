class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :saying, foreign_key: true
      t.integer :points,    default: 0

      t.timestamps
      t.index %i[user_id saying_id], unique: true
    end
  end
end
