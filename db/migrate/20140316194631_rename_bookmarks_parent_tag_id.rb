class RenameBookmarksParentTagId < ActiveRecord::Migration
  def change
  	rename_column :tags, :parent_tag_id, :tag_id
  end
end
