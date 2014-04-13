# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  url        :string(255)
#  page_text  :text
#  notes      :text
#  created_at :datetime
#  updated_at :datetime
#  domain     :string(255)
#  page_title :string(255)
#

class Bookmark < ActiveRecord::Base
	belongs_to :user
	has_many :bookmark_tag_associations
	has_many :tags, through: :bookmark_tag_associations
	has_many :keywords

	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	mapping do
	  indexes :id, type: 'integer', index: "no" 
	  indexes :user_id, type: 'integer', index: "no" 
	  indexes :title, boost: 10
	  indexes :url, boost: 20
	  indexes :page_text, analyzer: 'snowball', include_in_all: false
	  indexes :page_title, boost: 5
	  indexes :notes, boost: 3
	  indexes :created_at, type: 'date', index: "no"	  
	  indexes :updated_at, type: 'date', index: "no"	  
	  indexes :domain, type: 'string', index: "no"
	end

	def self.search_bookmarks(query, args = {})
		fields = ["_all"]
		unless args[:include_pages].empty?
			fields << "page_text"
		end
		Bookmark.search query: { multi_match: { 
				query: query,
				fields: fields,
				operator: "and"
			} }
	end

	def self.import_chrome
		current_user = User.find_or_create_by(id: 1)
		bookmarks = Markio::parse(open("tmp/bookmarks_3_16_14.html"))
		Bookmark.record_timestamps = true
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
		Bookmark.record_timestamps = true
	end

	def self.parse_domain(url)
	  url = "http://#{url}" unless url =~ /^http/i
	  parsed = Domainatrix.parse(url) rescue nil
	  parsed ? "#{parsed.domain}.#{parsed.public_suffix}".downcase : nil
	end

	def self.extract_keywords(bookmark)
		bookmark.keywords.delete
		results = AlchemyAPI::KeywordExtraction.new.search(:url => bookmark.url)
		results.each do |keyword|
			bookmark.keywords << Keyword.create( keyword: keyword["text"], relevance: keyword["relevance"] )
		end
	end

	def self.extract_text(bookmark)
		bookmark.page_text = AlchemyAPI::TextExtraction.new.search(:url => bookmark.url)
		bookmark.save
	end

	def self.extract_title(bookmark)
		body = HTTParty.get(bookmark.url, { timeout: 3 }) rescue nil
		if body
			bookmark.page_title = Nokogiri::HTML::Document.parse(HTTParty.get(bookmark.url).body).title
			bookmark.save
		end
	end
end
