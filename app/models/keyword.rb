# == Schema Information
#
# Table name: keywords
#
#  id          :integer          not null, primary key
#  bookmark_id :integer
#  keyword     :string(255)
#  relevance   :float
#

class Keyword < ActiveRecord::Base
	has_many :bookmarks
end
