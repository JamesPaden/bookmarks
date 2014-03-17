class BookmarksController < ApplicationController
	def home
		@bookmarks = Bookmark.order(updated_at: :desc, created_at: :desc).limit(40)
	end
end
