# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
	has_many :bookmarks
	has_many :tags
end
