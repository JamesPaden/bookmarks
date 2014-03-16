# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  type       :string(255)
#  tag_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
	has_many :bookmark_tag_associations
	has_many :bookmarks, through: :bookmark_tag_associations
	# belongs_to :tags
	# has_many :tags
	belongs_to :users
end
