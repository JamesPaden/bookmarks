class FixUniqueTagIndex < ActiveRecord::Migration
  def change
  	remove_index :tags, name: "index_tags_on_user_id_and_title_and_type"
  	add_index :tags, [:user_id, :title, :type, :tag_id], unique: true
  end
end
