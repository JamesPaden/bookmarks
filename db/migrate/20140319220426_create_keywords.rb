class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
    	t.integer :bookmark_id
    	t.string :keyword
    	t.float :relevance
    end
  end
end
