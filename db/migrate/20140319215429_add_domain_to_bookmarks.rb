class AddDomainToBookmarks < ActiveRecord::Migration
  def change
  	add_column :bookmarks, :domain, :string
  end
end
