class BookmarksController < ApplicationController
	def home
		if params[:q]
			@bookmarks = Bookmark.search_bookmarks(params[:q], params[:args])
		else
			@bookmarks = Bookmark.order(updated_at: :desc, created_at: :desc).limit(40)
		end
	end
end
