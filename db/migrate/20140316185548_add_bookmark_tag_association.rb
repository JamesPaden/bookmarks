class AddBookmarkTagAssociation < ActiveRecord::Migration
  def change
  	remove_column :tags, :bookmark_id

  	create_table :bookmark_tag_associations do |t|
  		t.integer :tag_id
  		t.integer :bookmark_id
  		t.timestamps
  	end
  end
end
