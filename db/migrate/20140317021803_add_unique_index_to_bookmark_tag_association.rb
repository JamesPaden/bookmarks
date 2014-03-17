class AddUniqueIndexToBookmarkTagAssociation < ActiveRecord::Migration
  def change
  	add_index :bookmark_tag_associations, [:tag_id, :bookmark_id], unique: true
  end
end
