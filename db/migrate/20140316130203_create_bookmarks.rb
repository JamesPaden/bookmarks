class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.string :title
      t.string :url
      t.text :description
      t.text :keywords
      t.text :notes

      t.timestamps
    end
  end
end
