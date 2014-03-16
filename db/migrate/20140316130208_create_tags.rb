class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :user_id
      t.integer :bookmark_id
      t.string :title
      t.string :type
      t.integer :parent_tag_id

      t.timestamps
    end
  end
end
