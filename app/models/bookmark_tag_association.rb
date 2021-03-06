# == Schema Information
#
# Table name: bookmark_tag_associations
#
#  id          :integer          not null, primary key
#  tag_id      :integer
#  bookmark_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class BookmarkTagAssociation < ActiveRecord::Base
	belongs_to :bookmark
	belongs_to :tag
	validates_uniqueness_of :bookmark, scope: [:tag], on: :create
end
