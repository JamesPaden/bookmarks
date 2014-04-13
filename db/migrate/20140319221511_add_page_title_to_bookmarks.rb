class AddPageTitleToBookmarks < ActiveRecord::Migration
  def change
  	add_column :bookmarks, :page_title, :string
  	rename_column :bookmarks, :description, :page_text
  	remove_column :bookmarks, :keywords
  end
end
