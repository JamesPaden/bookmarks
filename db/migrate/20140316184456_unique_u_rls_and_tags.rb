class UniqueURlsAndTags < ActiveRecord::Migration
  def change
  	add_index :bookmarks, [:url, :user_id], unique: true
  	add_index :tags, [:user_id, :title, :type], unique: true
  end
end
