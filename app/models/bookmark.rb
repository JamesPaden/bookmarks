# == Schema Information
#
# Table name: bookmarks
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  url         :string(255)
#  description :text
#  keywords    :text
#  notes       :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Bookmark < ActiveRecord::Base
	belongs_to :user
	has_many :bookmark_tag_associations
	has_many :tags, through: :bookmark_tag_associations

	def self.import_chrome
		current_user = User.find_or_create_by(id: 1)
		bookmarks = Markio::parse(open("tmp/bookmarks_3_16_14.html"))
		bookmarks.each do |b|
			bookmark = current_user.bookmarks.find_or_create_by(url: b.href)
			bookmark.title = b.title
			bookmark.created_at = b.add_date
			bookmark.updated_at = b.last_modified
			bookmark.save
			parent_id = 0
			b.folders.each do |category_name|
				tag = current_user.tags.find_or_create_by(title: category_name, tag_type: "category", tag_id: parent_id)
				parent_id = tag.id
				puts tag
				bookmark.bookmark_tag_associations.create(tag_id: tag.id)
			end
		end
	end
end
